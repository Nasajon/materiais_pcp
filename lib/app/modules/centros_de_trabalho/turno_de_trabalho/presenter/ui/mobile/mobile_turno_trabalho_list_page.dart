import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/states/turno_trabalho_state.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/widgets/turno_trabalho_item_widget.dart';

class MobileTurnoTrabalhoListPage extends StatelessWidget {
  final TurnoTrabalhoListStore turnoTrabalhoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const MobileTurnoTrabalhoListPage({
    Key? key,
    required this.turnoTrabalhoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;

    return CustomScaffold.titleString(
      translation.titles.turnosDeTrabalho,
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
                  label: translation.messages.pesquisarNomeOuPalavraChave,
                  onChanged: (value) => turnoTrabalhoListStore.search = value,
                ),
              ),
              const SizedBox(height: 40),
              ScopedBuilder<TurnoTrabalhoListStore, List<TurnoTrabalhoState>>(
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
                            turnoTrabalhoListStore.search.isEmpty
                                ? translation.messages.nenhumTurnoTrabalhoEncontrado
                                : translation.messages.naoHaResultadosParaPesquisa,
                            style: AnaTextStyles.grey20Px,
                          ),
                        ),
                      } else if (turnoTrabalhoListStore.search.isEmpty) ...{
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: Text(
                            translation.titles.ultimosTurnosAcessados,
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
                              return TurnoTrabalhoItemWidget(
                                key: ValueKey('${value.turnoTrabalho.codigo} - ${value.turnoTrabalho.nome}'),
                                turnoTrabalho: value.turnoTrabalho,
                                deletarTurnoTrabalhoStore: value.deletarStore,
                                turnoTrabalhoListStore: turnoTrabalhoListStore,
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
            CustomPrimaryButton(title: translation.fields.criarTurno, onPressed: () => Modular.to.pushNamed('./new'))
          ],
        ),
      ),
    );
  }
}
