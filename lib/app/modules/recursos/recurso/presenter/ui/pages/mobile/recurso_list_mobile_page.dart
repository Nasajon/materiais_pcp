import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/states/recurso_state.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/ui/widgets/recurso_item_widget.dart';

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
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    const horizontalPadding = 16.0;

    return CustomScaffold.titleString(
      translation.titles.tituloRecursos,
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
              ScopedBuilder<RecursoListStore, List<RecursoState>>(
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
                          onChanged: (value) => widget.recursoListStore.search = value,
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (state.isEmpty) ...{
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
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
                          child: Text(
                            translation.titles.ultimosRecursosAcessados,
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
                              return RecursoItemWidget(
                                key: ValueKey('${value.recurso.codigo} - ${value.recurso.descricao}'),
                                recurso: value.recurso,
                                deletarRecursoStore: value.deletarStore,
                                recursoListStore: widget.recursoListStore,
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
            CustomTextButton(
              title: translation.fields.voltar,
              onPressed: () => Modular.to.pop(),
            ),
            const SizedBox(width: 12),
            CustomPrimaryButton(
                title: translation.fields.criarGrupo,
                onPressed: () async {
                  await Modular.to.pushNamed('./new');

                  widget.recursoListStore.getList();
                })
          ],
        ),
      ),
    );
  }
}
