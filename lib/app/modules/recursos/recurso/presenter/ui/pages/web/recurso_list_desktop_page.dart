import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/states/recurso_state.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/ui/widgets/recurso_item_widget.dart';

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

class _RecursoListDesktopPageState extends State<RecursoListDesktopPage> with DialogErrorMixin<RecursoListDesktopPage, RecursoListStore> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      translation.titles.tituloRecursos,
      controller: widget.scaffoldController,
      alignment: Alignment.centerLeft,
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 635),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ScopedBuilder<RecursoListStore, List<RecursoState>>(
                  store: widget.recursoListStore,
                  onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                  onState: (context, state) {
                    final createRecursoButton = Center(
                      child: CustomPrimaryButton(
                        title: translation.fields.criarGrupo,
                        onPressed: () async {
                          await Modular.to.pushNamed('./new');
                          widget.recursoListStore.getList();
                        },
                      ),
                    );

                    final recursoSearch = [
                      const SizedBox(height: 40),
                      PesquisaFormFieldWidget(
                        label: translation.messages.pesquisarNomeOuPalavraChave,
                        onChanged: (value) => widget.recursoListStore.search = value,
                      ),
                      const SizedBox(height: 40),
                    ];

                    if (state.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...recursoSearch,
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
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
                        ...recursoSearch,
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
                                  key: ValueKey('${value.recurso.codigo} - ${value.recurso.descricao}'),
                                  recurso: value.recurso,
                                  deletarRecursoStore: value.deletarStore,
                                  recursoListStore: widget.recursoListStore,
                                );
                              }).toList(),
                              const SizedBox(height: 16),
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
