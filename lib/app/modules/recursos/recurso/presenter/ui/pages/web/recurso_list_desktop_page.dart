import 'package:ana_l10n/ana_l10n.dart';
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';

import '../../../../domain/entities/recurso.dart';
import '../../../stores/recurso_list_store.dart';

class RecursoListDesktopPage extends StatelessWidget {
  final RecursoListStore recursoListStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const RecursoListDesktopPage({
    Key? key,
    required this.recursoListStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.titleString(
      context.l10n.materiaisPcpRecursos,
      alignment: Alignment.centerLeft,
      onIconTap: () => Modular.to.pop(),
      controller: scaffoldController,
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
                  label: context.l10n.materiaisPcpPesquisa,
                  controller: recursoListStore.pesquisaController,
                  onChanged: (value) => recursoListStore.getList(search: value),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: ScopedBuilder<RecursoListStore, List<Recurso>>(
                    store: recursoListStore,
                    onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                    onError: (context, error) => Container(),
                    onState: (context, state) {
                      List<Widget> widgets = [];

                      if (state.isEmpty) {
                        widgets.add(
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              recursoListStore.pesquisaController.text.isEmpty
                                  ? context.l10n
                                      .materiaisPcpNenhumaEntidadeEncontradaMasculino(context.l10n.materiaisPcpRecurso.toLowerCase())
                                  : context.l10n.materiaisPcpNaoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                        );
                      } else {
                        if (recursoListStore.pesquisaController.text.isEmpty) {
                          widgets.add(Text(context.l10n.materiaisPcpUltimosRecursosAcessados,
                              style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18)));
                        }

                        widgets.add(
                          Flexible(
                            child: _RecursoList(
                              recursos: state,
                              recursoListStore: recursoListStore,
                            ),
                          ),
                        );
                      }

                      widgets.add(
                        Center(
                          child: CustomPrimaryButton(
                            title: context.l10n.materiaisPcpCriarRecurso,
                            onPressed: () async {
                              await Modular.to.pushNamed('./new');

                              recursoListStore.getList(
                                search: recursoListStore.pesquisaController.text,
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
                    },
                  ),
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
  final RecursoListStore recursoListStore;
  final List<Recurso> recursos;

  const _RecursoList({
    Key? key,
    required this.recursos,
    required this.recursoListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10nLocalization = context.l10nLocalization;

    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: ListView(
        shrinkWrap: true,
        children: recursos
            .map((recurso) => ListTileWidget(
                  title: '${recurso.codigo} - ${recurso.descricao}',
                  subtitle: '${context.l10n.materiaisPcpTipoDeRecurso}: ${recurso.grupoDeRecurso?.tipo?.name(l10nLocalization)}',
                  onTap: () async {
                    await Modular.to.pushNamed('./${recurso.id}');

                    recursoListStore.getList(
                      search: recursoListStore.pesquisaController.text,
                      delay: Duration.zero,
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}
