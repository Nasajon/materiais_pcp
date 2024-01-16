import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/roteiro_list_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/states/roteiro_state.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/widgets/roteiro_item_widget.dart';

class MobileRoteiroListPage extends StatefulWidget {
  final RoteiroListStore roteiroListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const MobileRoteiroListPage({
    Key? key,
    required this.roteiroListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<MobileRoteiroListPage> createState() => _MobileRoteiroListPageState();
}

class _MobileRoteiroListPageState extends State<MobileRoteiroListPage> with DialogErrorMixin<MobileRoteiroListPage, RoteiroListStore> {
  @override
  void initState() {
    super.initState();
    widget.roteiroListStore.getRoteiros(delay: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;

    final pesquisaFieldWidget = <Widget>[
      const SizedBox(height: 40),
      PesquisaFormFieldWidget(
        label: translation.messages.pesquisarNomeOuPalavraChave,
        onChanged: (value) => widget.roteiroListStore.getRoteiros(search: value),
      ),
      const SizedBox(height: 40),
    ];

    return CustomScaffold.titleString(
      translation.titles.roteiroDeProducao,
      controller: widget.scaffoldController,
      alignment: Alignment.centerLeft,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 635),
        child: ScopedBuilder<RoteiroListStore, List<RoteiroState>>(
          onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
          onError: (context, error) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...pesquisaFieldWidget,
                Text(
                  'Erro',
                  style: AnaTextStyles.grey20Px,
                ),
              ],
            ),
          ),
          onState: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...pesquisaFieldWidget,
                    if (state.isEmpty) ...{
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                        child: Text(
                          widget.roteiroListStore.search.isEmpty
                              ? translation.messages.nenhumEntidadeEncontrado(translation.fields.roteiro)
                              : translation.messages.naoHaResultadosParaPesquisa,
                          style: AnaTextStyles.grey20Px,
                        ),
                      ),
                    } else if (widget.roteiroListStore.search.isEmpty) ...{
                      Text(
                        translation.titles.ultimosRoteirosAcessados,
                        style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 32),
                    },
                    Column(
                      children: state.map(
                        (value) {
                          return RoteiroItemWidget(
                            key: ValueKey(value),
                            roteiro: value.roteiro,
                            deletarRoteiroStore: value.deletarRoteiroStore,
                            roteiroListStore: widget.roteiroListStore,
                          );
                        },
                      ).toList(),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(
              title: translation.fields.voltar,
              onPressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
            ),
            const SizedBox(width: 12),
            CustomPrimaryButton(
              title: translation.fields.criarRoteiro,
              onPressed: () => Modular.to.pushNamed(NavigationRouter.roteirosModule.createPath),
            )
          ],
        ),
      ),
    );
  }
}
