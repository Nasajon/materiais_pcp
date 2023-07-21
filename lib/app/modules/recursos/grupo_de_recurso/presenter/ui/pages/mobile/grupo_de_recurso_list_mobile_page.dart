import 'package:ana_l10n/ana_l10n.dart';
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

import '../../../stores/grupo_de_recurso_list_store.dart';

class GrupoDeRecursoListMobilePage extends StatelessWidget {
  final GrupoDeRecursoListStore grupoDeRecursoStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRecursoListMobilePage({
    Key? key,
    required this.grupoDeRecursoStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.titleString(
      context.l10n.materiaisPcpGruposDeRecurso,
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
              label: context.l10n.materiaisPcpPesquisa,
              controller: grupoDeRecursoStore.pesquisaController,
              onChanged: (value) => grupoDeRecursoStore.getList(search: value),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ScopedBuilder<GrupoDeRecursoListStore, List<GrupoDeRecurso>>(
                store: grupoDeRecursoStore,
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
                            grupoDeRecursoStore.pesquisaController.text.isEmpty
                                ? context.l10n
                                    .materiaisPcpNenhumaEntidadeEncontradaMasculino(context.l10n.materiaisPcpGrupoDeRecurso.toLowerCase())
                                : context.l10n.materiaisPcpNaoHaResultadosParaPesquisa,
                            style: AnaTextStyles.grey20Px,
                          ),
                        ),
                      ),
                    );
                  } else {
                    if (grupoDeRecursoStore.pesquisaController.text.isEmpty) {
                      widgets.add(
                        Text(
                          context.l10n.materiaisPcpUltimosGruposAcessados,
                          style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                        ),
                      );
                    }

                    widgets.add(
                      Expanded(
                        child: _GrupoDeRecursosList(
                          gruposDeRecursos: state,
                          store: grupoDeRecursoStore,
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
            CustomTextButton(title: context.l10n.materiaisPcpVoltar, onPressed: () => Modular.to.pop()),
            const SizedBox(width: 12),
            CustomPrimaryButton(title: context.l10n.materiaisPcpCriarGrupo, onPressed: () => Modular.to.pushNamed('./new'))
          ],
        ),
      ),
    );
  }
}

class _GrupoDeRecursosList extends StatelessWidget {
  final GrupoDeRecursoListStore store;
  final List<GrupoDeRecurso> gruposDeRecursos;

  const _GrupoDeRecursosList({
    Key? key,
    required this.gruposDeRecursos,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: ListView(
        shrinkWrap: true,
        children: gruposDeRecursos.map((grupoDeRecurso) {
          return ListTileWidget(
            title: '${grupoDeRecurso.codigo} - ${grupoDeRecurso.descricao}',
            subtitle: '${context.l10n.materiaisPcpTipoDeRecurso}: ${grupoDeRecurso.tipo?.name(context.l10nLocalization)}',
            onTap: () async {
              await Modular.to.pushNamed('./${grupoDeRecurso.id}');

              store.getList(
                search: store.pesquisaController.text,
                delay: Duration.zero,
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
