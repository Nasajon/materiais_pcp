import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/roteiro_list_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/states/roteiro_state.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/widgets/roteiro_item_widget.dart';

class DesktopRoteiroListPage extends StatefulWidget {
  final RoteiroListStore roteiroListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const DesktopRoteiroListPage({
    Key? key,
    required this.roteiroListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<DesktopRoteiroListPage> createState() => _DesktopRoteiroListPageState();
}

class _DesktopRoteiroListPageState extends State<DesktopRoteiroListPage> with DialogErrorMixin<DesktopRoteiroListPage, RoteiroListStore> {
  @override
  void initState() {
    super.initState();
    widget.roteiroListStore.getRoteiros(delay: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    final createRoteiroButton = Center(
      child: CustomPrimaryButton(
        title: translation.fields.criarEntity(translation.fields.roteiro),
        onPressed: () async {
          await Modular.to.pushNamed(NavigationRouter.roteirosModule.createPath);
        },
      ),
    );

    return CustomScaffold.titleString(
      translation.titles.roteiroDeProducao,
      controller: widget.scaffoldController,
      alignment: Alignment.centerLeft,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 635),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ScopedBuilder<RoteiroListStore, List<RoteiroState>>(
                  store: widget.roteiroListStore,
                  onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                  onError: (_, error) {
                    final pesquisaFieldWidget = <Widget>[
                      const SizedBox(height: 40),
                      PesquisaFormFieldWidget(
                        label: translation.messages.pesquisarNomeOuPalavraChave,
                        initialValue: widget.roteiroListStore.search,
                        onChanged: (value) {
                          widget.roteiroListStore.search = value;
                          widget.roteiroListStore.getRoteiros(search: value);
                        },
                      ),
                      const SizedBox(height: 40),
                    ];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...pesquisaFieldWidget,
                        Text(
                          'Erro',
                          style: AnaTextStyles.grey20Px,
                        ),
                        createRoteiroButton,
                      ],
                    );
                  },
                  onState: (context, state) {
                    final pesquisaFieldWidget = <Widget>[
                      const SizedBox(height: 40),
                      PesquisaFormFieldWidget(
                        label: translation.messages.pesquisarNomeOuPalavraChave,
                        initialValue: widget.roteiroListStore.search,
                        onChanged: (value) {
                          widget.roteiroListStore.search = value;
                          widget.roteiroListStore.getRoteiros(search: value);
                        },
                      ),
                      const SizedBox(height: 40),
                    ];

                    if (state.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...pesquisaFieldWidget,
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              widget.roteiroListStore.search.isEmpty
                                  ? translation.messages.nenhumEntidadeEncontrado(translation.fields.roteiro)
                                  : translation.messages.naoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                          createRoteiroButton,
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...pesquisaFieldWidget,
                        if (widget.roteiroListStore.search.isEmpty) ...{
                          Text(
                            translation.titles.ultimosRoteirosAcessados,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 40),
                        },
                        Flexible(
                          child: ListView(
                            children: [
                              ...state.map((value) {
                                return RoteiroItemWidget(
                                  key: ValueKey(value),
                                  roteiro: value.roteiro,
                                  deletarRoteiroStore: value.deletarRoteiroStore,
                                  roteiroListStore: widget.roteiroListStore,
                                );
                              }).toList(),
                              const SizedBox(height: 16),
                              createRoteiroButton,
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
