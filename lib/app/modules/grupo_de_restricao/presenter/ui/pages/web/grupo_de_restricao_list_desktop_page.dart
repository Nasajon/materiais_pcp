import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/stores/grupo_de_restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/stores/states/grupo_de_restricao_state.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/ui/widgets/grupo_de_restricao_item_widget.dart';

class GrupoDeRestricaoListDesktopPage extends StatelessWidget {
  final GrupoDeRestricaoListStore grupoDeRestricaoStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRestricaoListDesktopPage({
    Key? key,
    required this.grupoDeRestricaoStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.titleString(
      translation.titles.gruposDeRestricao,
      alignment: Alignment.centerLeft,
      controller: scaffoldController,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 635),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PesquisaFormFieldWidget(
                  label: translation.messages.avisoPesquisarPorNomeOuPalavraChave,
                  controller: grupoDeRestricaoStore.pesquisaController,
                  onChanged: (value) => grupoDeRestricaoStore.getList(search: value),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: ScopedBuilder<GrupoDeRestricaoListStore, List<GrupoDeRestricaoState>>(
                      store: grupoDeRestricaoStore,
                      onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                      onError: (context, error) => Container(),
                      onState: (context, state) {
                        List<Widget> widgets = [];

                        if (state.isEmpty) {
                          widgets.add(
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                grupoDeRestricaoStore.pesquisaController.text.isEmpty
                                    ? translation.messages.nenhumEntidadeEncontrado(translation.fields.grupoDeRestricao)
                                    : translation.messages.naoHaResultadosParaPesquisa,
                                style: AnaTextStyles.grey20Px,
                              ),
                            ),
                          );
                        } else {
                          if (grupoDeRestricaoStore.pesquisaController.text.isEmpty) {
                            widgets.add(Text(translation.titles.ultimosGruposAcessados,
                                style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18)));
                          }

                          widgets.add(Flexible(
                            child: _GrupoDeRestricaosList(
                              listGrupoDeRestricaoState: state,
                              grupoDeRestricaoListStore: grupoDeRestricaoStore,
                            ),
                          ));
                        }

                        widgets.add(
                          Center(
                            child: CustomPrimaryButton(
                              title: translation.fields.criarGrupo,
                              onPressed: () async {
                                await Modular.to.pushNamed(NavigationRouter.gruposDeRestricoesModule.createPath);

                                grupoDeRestricaoStore.getList(
                                  search: grupoDeRestricaoStore.pesquisaController.text,
                                  delay: Duration.zero,
                                );
                              },
                            ),
                          ),
                        );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: widgets,
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GrupoDeRestricaosList extends StatelessWidget {
  final GrupoDeRestricaoListStore grupoDeRestricaoListStore;
  final List<GrupoDeRestricaoState> listGrupoDeRestricaoState;

  const _GrupoDeRestricaosList({
    Key? key,
    required this.grupoDeRestricaoListStore,
    required this.listGrupoDeRestricaoState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: ListView(
        shrinkWrap: true,
        children: listGrupoDeRestricaoState.map(
          (state) {
            return GrupoDeRestricaoItemWidget(
              key: ValueKey(state.grupoDeRestricao.id),
              grupoDeRestricao: state.grupoDeRestricao,
              deletarGrupoDeRestricaoStore: state.deletarStore,
              grupoDeRestricaoListStore: grupoDeRestricaoListStore,
            );
          },
        ).toList(),
      ),
    );
  }
}
