import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/states/recurso_state.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/ui/widgets/recurso_item_widget.dart';

import '../../../stores/recurso_list_store.dart';

class RecursoListDesktopPage extends StatefulWidget {
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
  State<RecursoListDesktopPage> createState() => _RecursoListDesktopPageState();
}

class _RecursoListDesktopPageState extends State<RecursoListDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return NhidsScaffold.title(
      title: translation.titles.tituloRecursos,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 635.responsive),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              NhidsSearchFormField(
                initialValue: widget.recursoListStore.search,
                onChanged: (value) {
                  widget.recursoListStore.search = value;
                  widget.recursoListStore.getList(search: widget.recursoListStore.search);
                },
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ScopedBuilder<RecursoListStore, List<RecursoState>>(
                  store: widget.recursoListStore,
                  onLoading: (_) => const Center(child: CircularProgressIndicator()),
                  onState: (context, state) {
                    final createRecursoButton = Center(
                      child: NhidsPrimaryButton(
                        label: translation.fields.criarRecurso,
                        onPressed: () async {
                          await Modular.to.pushNamed(NavigationRouter.recursosModule.createPath);
                          widget.recursoListStore.getList();
                        },
                      ),
                    );

                    if (state.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.responsive),
                            child: Text(
                              widget.recursoListStore.search.isEmpty
                                  ? translation.messages.nenhumEntidadeEncontrado(translation.fields.recurso)
                                  : translation.messages.naoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                          createRecursoButton,
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.recursoListStore.search.isEmpty) ...{
                          Text(
                            translation.titles.ultimosRecursosAcessados,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 40),
                        },
                        Flexible(
                          child: ListView(
                            children: [
                              ...state.map((value) {
                                return RecursoItemWidget(
                                  recurso: value.recurso,
                                  deletarRecursoStore: value.deletarStore,
                                  recursoListStore: widget.recursoListStore,
                                );
                              }).toList(),
                              SizedBox(height: 16.responsive),
                              createRecursoButton,
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
