import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../../../../grupo_de_recurso/presenter/ui/pages/web/grupo_de_recurso_list_desktop_page.dart';
import '../../../../domain/entities/recurso.dart';
import '../../../stores/recurso_list_store.dart';
import '../../widgets/recurso_item.dart';

class RecursoListDesktopPage extends StatelessWidget {
  RecursoListDesktopPage({super.key});

  final _store = Modular.get<RecursoListStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBasicAppBar.backButton(
          title: context.l10n.materiaisPcpRecursos,
          onPressed: () => Modular.to.pop()),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 635),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PesquisaFormField(
                  label: context.l10n.materiaisPcpPesquisa,
                  controller: _store.pesquisaController,
                  onChanged: (value) => _store.getList(search: value),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child:
                      ScopedBuilder<RecursoListStore, Failure, List<Recurso>>(
                          store: _store,
                          onLoading: (_) => const Center(
                              child: CircularProgressIndicator(
                                  color: AnaColors.darkBlue)),
                          onError: (context, error) => Container(),
                          onState: (context, state) {
                            List<Widget> widgets = [];

                            if (state.isEmpty) {
                              widgets.add(
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    _store.pesquisaController.text.isEmpty
                                        ? context.l10n
                                            .materiaisPcpNenhumaEntidadeEncontradaMasculino(
                                                context.l10n.materiaisPcpRecurso
                                                    .toLowerCase())
                                        : context.l10n
                                            .materiaisPcpNaoHaResultadosParaPesquisa,
                                    style: AnaTextStyles.grey20Px,
                                  ),
                                ),
                              );
                            } else {
                              if (_store.pesquisaController.text.isEmpty) {
                                widgets.add(Text(
                                    context.l10n
                                        .materiaisPcpUltimosRecursosAcessados,
                                    style: AnaTextStyles.boldDarkGrey16Px
                                        .copyWith(fontSize: 18)));
                              }

                              widgets.add(Flexible(
                                child: _RecursoList(
                                  recursos: state,
                                  store: _store,
                                ),
                              ));
                            }

                            widgets.add(
                              Center(
                                child: CustomPrimaryButton(
                                  title: context.l10n.materiaisPcpCriarRecurso,
                                  onPressed: () async {
                                    await Modular.to.pushNamed('./new');

                                    _store.getList(
                                      search: _store.pesquisaController.text,
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

class _RecursoList extends StatelessWidget {
  final RecursoListStore store;
  final List<Recurso> recursos;

  const _RecursoList({
    Key? key,
    required this.recursos,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 24),
        child: ListView(
          shrinkWrap: true,
          children: recursos
              .map((recurso) => RecursoItem(
                    recurso: recurso,
                    onTap: () async {
                      await Modular.to.pushNamed('./${recurso.id}');

                      store.getList(
                        search: store.pesquisaController.text,
                        delay: Duration.zero,
                      );
                    },
                  ))
              .toList(),
        ));
  }
}
