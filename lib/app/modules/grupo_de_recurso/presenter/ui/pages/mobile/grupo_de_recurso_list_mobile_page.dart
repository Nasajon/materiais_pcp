import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../../../domain/entities/grupo_de_recurso.dart';
import '../../../stores/grupo_de_recurso_list_store.dart';
import '../../widgets/grupo_de_recurso_item.dart';
import '../web/grupo_de_recurso_list_desktop_page.dart';

class GrupoDeRecursoListMobilePage extends StatelessWidget {
  GrupoDeRecursoListMobilePage({super.key});

  final _store = Modular.get<GrupoDeRecursoListStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBasicAppBar.backButton(
          title: context.l10n.materiaisPcpGruposDeRecurso,
          onPressed: () => Modular.to.pop()),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PesquisaFormField(
              label: context.l10n.materiaisPcpPesquisa,
              controller: _store.pesquisaController,
              onChanged: (value) => _store.getList(search: value),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ScopedBuilder<GrupoDeRecursoListStore, Failure,
                      List<GrupoDeRecurso>>(
                  store: _store,
                  onLoading: (_) => const Center(
                      child:
                          CircularProgressIndicator(color: AnaColors.darkBlue)),
                  onError: (context, error) => Container(),
                  onState: (_, state) {
                    List<Widget> widgets = [];

                    if (state.isEmpty) {
                      widgets.add(
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              _store.pesquisaController.text.isEmpty
                                  ? context.l10n
                                      .materiaisPcpNenhumaEntidadeEncontradaMasculino(
                                          context
                                              .l10n.materiaisPcpGrupoDeRecurso
                                              .toLowerCase())
                                  : context.l10n
                                      .materiaisPcpNaoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                        ),
                      );
                    } else {
                      if (_store.pesquisaController.text.isEmpty) {
                        widgets.add(Text(
                            context.l10n.materiaisPcpUltimosGruposAcessados,
                            style: AnaTextStyles.boldDarkGrey16Px
                                .copyWith(fontSize: 18)));
                      }

                      widgets.add(Expanded(
                        child: _GrupoDeRecursosList(
                          gruposDeRecursos: state,
                          store: _store,
                        ),
                      ));
                    }

                    widgets.add(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                              title: context.l10n.materiaisPcpVoltar,
                              onPressed: () => Modular.to.pop()),
                          const SizedBox(width: 10),
                          CustomPrimaryButton(
                              title: context.l10n.materiaisPcpCriarGrupo,
                              onPressed: () => Modular.to.pushNamed('./new'))
                        ],
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
        children: gruposDeRecursos
            .map((grupoDeRecurso) => GrupoDeRecursoItem(
                  grupoDeRecurso: grupoDeRecurso,
                  onTap: () async {
                    await Modular.to.pushNamed('./${grupoDeRecurso.id}');

                    store.getList(
                      search: store.pesquisaController.text,
                      delay: Duration.zero,
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}
