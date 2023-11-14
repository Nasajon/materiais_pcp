import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/widgets/ordem_de_producao_item_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/ordem_de_producao_list_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/states/ordem_de_producao_state.dart';

class DesktopOrdemDeProducaoListPage extends StatefulWidget {
  final OrdemDeProducaoListStore ordemDeProducaoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const DesktopOrdemDeProducaoListPage({
    Key? key,
    required this.ordemDeProducaoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<DesktopOrdemDeProducaoListPage> createState() => _DesktopOrdemDeProducaoListPageState();
}

class _DesktopOrdemDeProducaoListPageState extends State<DesktopOrdemDeProducaoListPage>
    with DialogErrorMixin<DesktopOrdemDeProducaoListPage, OrdemDeProducaoListStore> {
  @override
  void initState() {
    super.initState();
    widget.ordemDeProducaoListStore.getOrdemDeProducaos(delay: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    final createOrdemDeProducaoButton = Center(
      child: CustomPrimaryButton(
        title: translation.fields.criarEntity(translation.fields.ordemDeProducao),
        onPressed: () async {
          await Modular.to.pushNamed('./new');
        },
      ),
    );

    return CustomScaffold.titleString(
      translation.titles.ordemDeProducao,
      controller: widget.scaffoldController,
      alignment: Alignment.centerLeft,
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
                child: ScopedBuilder<OrdemDeProducaoListStore, List<OrdemDeProducaoState>>(
                  store: widget.ordemDeProducaoListStore,
                  onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                  onError: (_, error) {
                    final pesquisaFieldWidget = <Widget>[
                      const SizedBox(height: 40),
                      PesquisaFormFieldWidget(
                        label: translation.messages.pesquisarNomeOuPalavraChave,
                        initialValue: widget.ordemDeProducaoListStore.search,
                        onChanged: (value) {
                          widget.ordemDeProducaoListStore.search = value;
                          widget.ordemDeProducaoListStore.getOrdemDeProducaos(search: value);
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
                        createOrdemDeProducaoButton,
                      ],
                    );
                  },
                  onState: (context, state) {
                    final pesquisaFieldWidget = <Widget>[
                      const SizedBox(height: 40),
                      PesquisaFormFieldWidget(
                        label: translation.messages.pesquisarNomeOuPalavraChave,
                        initialValue: widget.ordemDeProducaoListStore.search,
                        onChanged: (value) {
                          widget.ordemDeProducaoListStore.search = value;
                          widget.ordemDeProducaoListStore.getOrdemDeProducaos(search: value);
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
                              widget.ordemDeProducaoListStore.search.isEmpty
                                  ? translation.messages.nenhumaEntidadeEncontrada(translation.fields.ordemDeProducao)
                                  : translation.messages.naoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                          createOrdemDeProducaoButton,
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...pesquisaFieldWidget,
                        if (widget.ordemDeProducaoListStore.search.isEmpty) ...{
                          Text(
                            translation.titles.ultimasOrdensDeProducaosAcessados,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 40),
                        },
                        Flexible(
                          child: ListView(
                            children: [
                              ...state.map((value) {
                                return OrdemDeProducaoItemWidget(
                                  key: ValueKey(value),
                                  ordemDeProducao: value.ordemDeProducao,
                                  deletarOrdemDeProducaoStore: value.deletarOrdemDeProducaoStore,
                                  ordemDeProducaoListStore: widget.ordemDeProducaoListStore,
                                );
                              }).toList(),
                              const SizedBox(height: 16),
                              createOrdemDeProducaoButton,
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
