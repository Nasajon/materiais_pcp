// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/deletar_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/grupo_de_restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/states/grupo_de_restricao_state.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/ui/widgets/grupo_de_restricao_item_widget.dart';

import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

class GrupoDeRestricaoListMobilePage extends StatelessWidget {
  final GrupoDeRestricaoListStore grupoDeRestricaoStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRestricaoListMobilePage({
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
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                onState: (_, state) {
                  List<Widget> widgets = [];

                  if (state.isEmpty) {
                    widgets.add(
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            grupoDeRestricaoStore.pesquisaController.text.isEmpty
                                ? translation.messages.nenhumEntidadeEncontrado(translation.fields.grupoDeRestricao)
                                : translation.messages.naoHaResultadosParaPesquisa,
                            style: AnaTextStyles.grey20Px,
                          ),
                        ),
                      ),
                    );
                  } else {
                    if (grupoDeRestricaoStore.pesquisaController.text.isEmpty) {
                      widgets.add(
                        Text(
                          translation.titles.ultimosGruposAcessados,
                          style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                        ),
                      );
                    }

                    widgets.add(
                      Expanded(
                        child: _GrupoDeRestricaosList(
                          listGrupoDeRestricaoState: state,
                          grupoDeRestricaoListStore: grupoDeRestricaoStore,
                        ),
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widgets,
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(title: translation.fields.voltar, onPressed: () => Modular.to.pop()),
            const SizedBox(width: 12),
            CustomPrimaryButton(title: translation.fields.criarGrupo, onPressed: () => Modular.to.pushNamed('./new'))
          ],
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
        children: listGrupoDeRestricaoState.map((state) {
          return GrupoDeRestricaoItemWidget(
            key: ValueKey(state.grupoDeRestricao.id),
            grupoDeRestricao: state.grupoDeRestricao,
            deletarGrupoDeRestricaoStore: state.deletarStore,
            grupoDeRestricaoListStore: grupoDeRestricaoListStore,
          );
        }).toList(),
      ),
    );
  }
}
