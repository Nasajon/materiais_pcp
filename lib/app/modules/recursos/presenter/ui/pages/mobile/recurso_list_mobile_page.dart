import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/states/recurso_state.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/ui/widgets/recurso_item_widget.dart';

import '../../../stores/recurso_list_store.dart';

class RecursoListMobilePage extends StatefulWidget {
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
  State<RecursoListMobilePage> createState() => _RecursoListMobilePageState();
}

class _RecursoListMobilePageState extends State<RecursoListMobilePage> with DialogErrorMixin<RecursoListMobilePage, RecursoListStore> {
  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;

    return NhidsScaffold.title(
      title: translation.titles.tituloRecursos,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.responsive),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: NhidsSearchFormField(
                initialValue: widget.recursoListStore.search,
                onChanged: (value) {
                  widget.recursoListStore.search = value;
                  widget.recursoListStore.getList(search: widget.recursoListStore.search);
                },
              ),
            ),
            SizedBox(height: 40.responsive),
            ScopedBuilder<RecursoListStore, List<RecursoState>>(
              onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
              onError: (context, error) => Container(),
              onState: (context, state) => SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16.responsive),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.isEmpty) ...{
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.responsive, left: 16.responsive, right: 16.responsive),
                        child: Text(
                          widget.recursoListStore.search.isEmpty
                              ? translation.messages.nenhumEntidadeEncontrado(translation.fields.recurso)
                              : translation.messages.naoHaResultadosParaPesquisa,
                          style: AnaTextStyles.grey20Px,
                        ),
                      ),
                    } else if (widget.recursoListStore.search.isEmpty) ...{
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: NhidsTextTitle(
                          text: translation.titles.ultimosRecursosAcessados,
                        ),
                      ),
                      const SizedBox(height: 32),
                    },
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Column(
                        children: state.map(
                          (value) {
                            return RecursoItemWidget(
                              key: UniqueKey(),
                              recurso: value.recurso,
                              deletarRecursoStore: value.deletarStore,
                              recursoListStore: widget.recursoListStore,
                            );
                          },
                        ).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(
              title: translation.fields.voltar,
              onPressed: () => Modular.to.pop(),
            ),
            const SizedBox(width: 12),
            CustomPrimaryButton(
              title: translation.fields.criarGrupo,
              onPressed: () async {
                await Modular.to.pushNamed(NavigationRouter.recursosModule.createPath);

                widget.recursoListStore.getList();
              },
            ),
          ],
        ),
      ),
    );
  }
}
