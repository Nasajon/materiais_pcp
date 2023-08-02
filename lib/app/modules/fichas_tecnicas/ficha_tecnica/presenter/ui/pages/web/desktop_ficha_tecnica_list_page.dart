// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/ficha_tecnica_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/states/ficha_tecnica_state.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/ui/widgets/ficha_tecnica_item_widget.dart';

class DesktopFichaTecnicaListPage extends StatefulWidget {
  final FichaTecnicaListStore fichaTecnicaListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const DesktopFichaTecnicaListPage({
    Key? key,
    required this.fichaTecnicaListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<DesktopFichaTecnicaListPage> createState() => _DesktopFichaTecnicaListPageState();
}

class _DesktopFichaTecnicaListPageState extends State<DesktopFichaTecnicaListPage>
    with DialogErrorMixin<DesktopFichaTecnicaListPage, FichaTecnicaListStore> {
  @override
  Widget build(BuildContext context) {
    final l10n = translation;

    return CustomScaffold.titleString(
      l10n.titles.fichasTecnicas,
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
              const SizedBox(height: 40),
              PesquisaFormFieldWidget(
                label: context.l10n.materiaisPcpPesquisa,
                onChanged: (value) => widget.fichaTecnicaListStore.getListFichaTecnica(search: value),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ScopedBuilder<FichaTecnicaListStore, List<FichaTecnicaState>>(
                  store: widget.fichaTecnicaListStore,
                  onError: (_, __) => Container(),
                  onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                  onState: (context, state) {
                    final createFichaTecnicaButton = Center(
                      child: CustomPrimaryButton(
                        title: l10n.fields.criarFichaTecnica,
                        onPressed: () async {
                          await Modular.to.pushNamed('./new');
                        },
                      ),
                    );

                    if (state.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              widget.fichaTecnicaListStore.search.isEmpty
                                  ? l10n.messages.nenhumaFichaTecnicaEncontrada
                                  : context.l10n.materiaisPcpNaoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                          createFichaTecnicaButton,
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.fichaTecnicaListStore.search.isEmpty) ...{
                          Text(
                            l10n.titles.ultimasFichasTecnicasAcessadas,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 40),
                        },
                        Flexible(
                          child: ListView(
                            children: [
                              ...state.map((value) {
                                return FichaTecnicaItemWidget(
                                  key: ValueKey('${value.fichaTecnica.codigo}'),
                                  fichaTecnica: value.fichaTecnica,
                                  deletarFichaTecnicaStore: value.deletarStore,
                                  fichaTecnicaListStore: widget.fichaTecnicaListStore,
                                );
                              }).toList(),
                              const SizedBox(height: 16),
                              createFichaTecnicaButton,
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
