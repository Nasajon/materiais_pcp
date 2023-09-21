import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/ficha_tecnica_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/states/ficha_tecnica_state.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/ui/widgets/ficha_tecnica_item_widget.dart';

class MobileFichaTecnicaListPage extends StatelessWidget {
  final FichaTecnicaListStore fichaTecnicaListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const MobileFichaTecnicaListPage({
    Key? key,
    required this.fichaTecnicaListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = translation;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    const horizontalPadding = 16.0;

    return CustomScaffold.titleString(
      l10n.titles.fichasTecnicas,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: PesquisaFormFieldWidget(
                  label: context.l10n.materiaisPcpPesquisa,
                  onChanged: (value) => fichaTecnicaListStore.getListFichaTecnica(search: value),
                ),
              ),
              const SizedBox(height: 40),
              ScopedBuilder<FichaTecnicaListStore, List<FichaTecnicaState>>(
                onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                onError: (context, error) => Container(),
                onState: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.isEmpty) ...{
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                          child: Text(
                            fichaTecnicaListStore.search.isEmpty
                                ? l10n.messages.nenhumaFichaTecnicaEncontrada
                                : context.l10n.materiaisPcpNaoHaResultadosParaPesquisa,
                            style: AnaTextStyles.grey20Px,
                          ),
                        ),
                      } else if (fichaTecnicaListStore.search.isEmpty) ...{
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: Text(
                            l10n.titles.ultimasFichasTecnicasAcessadas,
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
                              return FichaTecnicaItemWidget(
                                key: ValueKey('${value.fichaTecnica.codigo} - ${value.fichaTecnica.descricao}'),
                                fichaTecnica: value.fichaTecnica,
                                deletarFichaTecnicaStore: value.deletarStore,
                                fichaTecnicaListStore: fichaTecnicaListStore,
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
            CustomTextButton(title: l10n.fields.voltar, onPressed: () => Modular.to.pop()),
            const SizedBox(width: 12),
            CustomPrimaryButton(title: l10n.fields.criarFichaTecnica, onPressed: () => Modular.to.pushNamed('./new'))
          ],
        ),
      ),
    );
  }
}
