// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/states/turno_trabalho_state.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/widgets/turno_trabalho_item_widget.dart';

class DesktopTurnoTrabalhoListPage extends StatefulWidget {
  final TurnoTrabalhoListStore turnoTrabalhoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const DesktopTurnoTrabalhoListPage({
    Key? key,
    required this.turnoTrabalhoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<DesktopTurnoTrabalhoListPage> createState() => _DesktopTurnoTrabalhoListPageState();
}

class _DesktopTurnoTrabalhoListPageState extends State<DesktopTurnoTrabalhoListPage>
    with DialogErrorMixin<DesktopTurnoTrabalhoListPage, TurnoTrabalhoListStore> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      l10n.titles.turnosDeTrabalho,
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
                onChanged: (value) => widget.turnoTrabalhoListStore.search = value,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ScopedBuilder<TurnoTrabalhoListStore, List<TurnoTrabalhoState>>(
                  store: widget.turnoTrabalhoListStore,
                  onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                  onState: (context, state) {
                    final createTurnoTrabalhoButton = Center(
                      child: CustomPrimaryButton(
                        title: l10n.fields.criarTurno,
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
                              widget.turnoTrabalhoListStore.search.isEmpty
                                  ? l10n.messages.nenhumTurnoTrabalhoEncontrado
                                  : context.l10n.materiaisPcpNaoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                          createTurnoTrabalhoButton,
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.turnoTrabalhoListStore.search.isEmpty) ...{
                          Text(
                            l10n.titles.ultimosTurnosAcessados,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 40),
                        },
                        Flexible(
                          child: ListView(
                            children: [
                              ...state.map((value) {
                                return TurnoTrabalhoItemWidget(
                                  key: ValueKey('${value.turnoTrabalho.codigo} - ${value.turnoTrabalho.nome}'),
                                  turnoTrabalho: value.turnoTrabalho,
                                  deletarTurnoTrabalhoStore: value.deletarStore,
                                  turnoTrabalhoListStore: widget.turnoTrabalhoListStore,
                                );
                              }).toList(),
                              const SizedBox(height: 16),
                              createTurnoTrabalhoButton,
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
