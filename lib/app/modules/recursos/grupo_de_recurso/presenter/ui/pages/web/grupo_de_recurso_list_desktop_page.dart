import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/stores/grupo_de_recurso_list_store.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/stores/states/grupo_de_recurso_state.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/ui/widgets/grupo_de_recurso_item_widget.dart';

class GrupoDeRecursoListDesktopPage extends StatefulWidget {
  final GrupoDeRecursoListStore grupoDeRecursoStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRecursoListDesktopPage({
    Key? key,
    required this.grupoDeRecursoStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<GrupoDeRecursoListDesktopPage> createState() => _GrupoDeRecursoListDesktopPageState();
}

class _GrupoDeRecursoListDesktopPageState extends State<GrupoDeRecursoListDesktopPage>
    with DialogErrorMixin<GrupoDeRecursoListDesktopPage, GrupoDeRecursoListStore> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold.titleString(
      translation.titles.gruposDeRecursos,
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
                child: ScopedBuilder<GrupoDeRecursoListStore, List<GrupoDeRecursoState>>(
                  store: widget.grupoDeRecursoStore,
                  onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                  onState: (context, state) {
                    final createGrupoDeRecursoButton = Center(
                      child: CustomPrimaryButton(
                        title: translation.fields.criarGrupo,
                        onPressed: () async {
                          await Modular.to.pushNamed('./new');

                          widget.grupoDeRecursoStore.getList();
                        },
                      ),
                    );

                    final grupoDeRecursoSearch = [
                      const SizedBox(height: 40),
                      PesquisaFormFieldWidget(
                        label: translation.messages.pesquisarNomeOuPalavraChave,
                        onChanged: (value) {
                          widget.grupoDeRecursoStore.search = value;
                          widget.grupoDeRecursoStore.getList(search: widget.grupoDeRecursoStore.search);
                        },
                      ),
                      const SizedBox(height: 40),
                    ];

                    if (state.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...grupoDeRecursoSearch,
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              widget.grupoDeRecursoStore.search.isEmpty
                                  ? translation.messages.nenhumEntidadeEncontrado(translation.fields.grupoDeRecurso)
                                  : translation.messages.naoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                          createGrupoDeRecursoButton,
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...grupoDeRecursoSearch,
                        if (widget.grupoDeRecursoStore.search.isEmpty) ...{
                          Text(
                            translation.titles.ultimosGruposAcessados,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 40),
                        },
                        Flexible(
                          child: ListView(
                            children: [
                              ...state.map((value) {
                                return GrupoDeRecursoItemWidget(
                                  key: ValueKey('${value.grupoDeRecurso.codigo} - ${value.grupoDeRecurso.descricao}'),
                                  grupoDeRecurso: value.grupoDeRecurso,
                                  deletarGrupoDeRecursoStore: value.deletarStore,
                                  grupoDeRecursoListStore: widget.grupoDeRecursoStore,
                                );
                              }).toList(),
                              const SizedBox(height: 16),
                              createGrupoDeRecursoButton,
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
