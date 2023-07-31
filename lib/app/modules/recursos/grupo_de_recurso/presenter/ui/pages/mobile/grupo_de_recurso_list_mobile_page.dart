import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/stores/states/grupo_de_recurso_state.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/ui/widgets/grupo_de_recurso_item_widget.dart';

import '../../../stores/grupo_de_recurso_list_store.dart';

class GrupoDeRecursoListMobilePage extends StatefulWidget {
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
  State<GrupoDeRecursoListMobilePage> createState() => _GrupoDeRecursoListMobilePageState();
}

class _GrupoDeRecursoListMobilePageState extends State<GrupoDeRecursoListMobilePage>
    with DialogErrorMixin<GrupoDeRecursoListMobilePage, GrupoDeRecursoListStore> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    const horizontalPadding = 16.0;

    return CustomScaffold.titleString(
      translation.titles.gruposDeRecursos,
      controller: widget.scaffoldController,
      alignment: Alignment.centerLeft,
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 635),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              ScopedBuilder<GrupoDeRecursoListStore, List<GrupoDeRecursoState>>(
                onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                onError: (context, error) => Container(),
                onState: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: PesquisaFormFieldWidget(
                          label: translation.messages.pesquisarNomeOuPalavraChave,
                          onChanged: (value) => widget.grupoDeRecursoStore.search = value,
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (state.isEmpty) ...{
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                          child: Text(
                            widget.grupoDeRecursoStore.search.isEmpty
                                ? translation.messages.nenhumEntidadeEncontrado(translation.fields.grupoDeRecurso)
                                : translation.messages.naoHaResultadosParaPesquisa,
                            style: AnaTextStyles.grey20Px,
                          ),
                        ),
                      } else if (widget.grupoDeRecursoStore.search.isEmpty) ...{
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: Text(
                            translation.titles.ultimosGruposAcessados,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 32),
                      },
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Column(
                          children: state.map(
                            (value) {
                              return GrupoDeRecursoItemWidget(
                                key: ValueKey('${value.grupoDeRecurso.codigo} - ${value.grupoDeRecurso.descricao}'),
                                grupoDeRecurso: value.grupoDeRecurso,
                                deletarGrupoDeRecursoStore: value.deletarStore,
                                grupoDeRecursoListStore: widget.grupoDeRecursoStore,
                              );
                            },
                          ).toList(),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(title: translation.fields.voltar, onPressed: () => Modular.to.pop()),
            const SizedBox(width: 12),
            CustomPrimaryButton(
                title: translation.fields.criarGrupo,
                onPressed: () async {
                  await Modular.to.pushNamed('./new');

                  widget.grupoDeRecursoStore.getList();
                })
          ],
        ),
      ),
    );
  }
}
