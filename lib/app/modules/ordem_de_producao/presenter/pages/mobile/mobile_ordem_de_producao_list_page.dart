import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/widgets/ordem_de_producao_item_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/ordem_de_producao_list_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/states/ordem_de_producao_state.dart';

class MobileOrdemDeProducaoListPage extends StatefulWidget {
  final OrdemDeProducaoListStore ordemDeProducaoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const MobileOrdemDeProducaoListPage({
    Key? key,
    required this.ordemDeProducaoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<MobileOrdemDeProducaoListPage> createState() => _MobileOrdemDeProducaoListPageState();
}

class _MobileOrdemDeProducaoListPageState extends State<MobileOrdemDeProducaoListPage>
    with DialogErrorMixin<MobileOrdemDeProducaoListPage, OrdemDeProducaoListStore> {
  @override
  void initState() {
    super.initState();
    widget.ordemDeProducaoListStore.getOrdemDeProducaos(delay: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;

    final pesquisaFieldWidget = <Widget>[
      const SizedBox(height: 40),
      PesquisaFormFieldWidget(
        label: translation.messages.pesquisarNomeOuPalavraChave,
        onChanged: (value) => widget.ordemDeProducaoListStore.getOrdemDeProducaos(search: value),
      ),
      const SizedBox(height: 40),
    ];

    return CustomScaffold.titleString(
      translation.titles.ordemDeProducao,
      controller: widget.scaffoldController,
      alignment: Alignment.centerLeft,
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 635),
        child: ScopedBuilder<OrdemDeProducaoListStore, List<OrdemDeProducaoState>>(
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
                          widget.ordemDeProducaoListStore.search.isEmpty
                              ? translation.messages.nenhumEntidadeEncontrado(translation.fields.ordemDeProducao)
                              : translation.messages.naoHaResultadosParaPesquisa,
                          style: AnaTextStyles.grey20Px,
                        ),
                      ),
                    } else if (widget.ordemDeProducaoListStore.search.isEmpty) ...{
                      Text(
                        translation.titles.ultimasOrdensDeProducaosAcessados,
                        style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 32),
                    },
                    Column(
                      children: state.map(
                        (value) {
                          return OrdemDeProducaoItemWidget(
                            key: ValueKey(value),
                            ordemDeProducao: value.ordemDeProducao,
                            deletarOrdemDeProducaoStore: value.deletarOrdemDeProducaoStore,
                            ordemDeProducaoListStore: widget.ordemDeProducaoListStore,
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
            CustomTextButton(title: translation.fields.voltar, onPressed: () => Modular.to.pop()),
            const SizedBox(width: 12),
            CustomPrimaryButton(title: translation.fields.criarOrdem, onPressed: () => Modular.to.pushNamed('./new'))
          ],
        ),
      ),
    );
  }
}
