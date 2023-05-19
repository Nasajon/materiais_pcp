// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';

import '../../../../../grupo_de_recurso/presenter/ui/pages/web/grupo_de_recurso_list_desktop_page.dart';
import '../../../../domain/entities/recurso.dart';
import '../../../stores/recurso_list_store.dart';
import '../../widgets/recurso_item.dart';

class RecursoListMobilePage extends StatelessWidget {
  final RecursoListStore recursoListStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const RecursoListMobilePage({
    Key? key,
    required this.recursoListStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.titleString(
      context.l10n.materiaisPcpRecursos,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      onIconTap: () => Modular.to.pop(),
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PesquisaFormField(
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
                  onState: (_, state) {
                    List<Widget> widgets = [];

                    if (state.isEmpty) {
                      widgets.add(
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              recursoListStore.pesquisaController.text.isEmpty
                                  ? context.l10n
                                      .materiaisPcpNenhumaEntidadeEncontradaMasculino(context.l10n.materiaisPcpRecurso.toLowerCase())
                                  : context.l10n.materiaisPcpNaoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                        ),
                      );
                    } else {
                      if (recursoListStore.pesquisaController.text.isEmpty) {
                        widgets.add(Text(context.l10n.materiaisPcpUltimosRecursosAcessados,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18)));
                      }

                      widgets.add(Expanded(
                        child: _RecursoList(
                          recursos: state,
                          store: recursoListStore,
                        ),
                      ));
                    }

                    widgets.add(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(title: context.l10n.materiaisPcpVoltar, onPressed: () => Modular.to.pop()),
                          const SizedBox(width: 10),
                          CustomPrimaryButton(title: context.l10n.materiaisPcpCriarRecurso, onPressed: () => Modular.to.pushNamed('./new'))
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
