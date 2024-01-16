import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/stores/centro_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/stores/states/centro_trabalho_state.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/ui/widgets/centro_trabalho_item_widget.dart';

class MobileCentroTrabalhoListPage extends StatelessWidget {
  final CentroTrabalhoListStore centroTrabalhoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const MobileCentroTrabalhoListPage({
    Key? key,
    required this.centroTrabalhoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;

    return CustomScaffold.titleString(
      translation.titles.centroDeTrabalho,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
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
                  onChanged: (value) {
                    centroTrabalhoListStore.search = value;
                    centroTrabalhoListStore.getListCentroTrabalho();
                  },
                ),
              ),
              const SizedBox(height: 40),
              ScopedBuilder<CentroTrabalhoListStore, List<CentroTrabalhoState>>(
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
                            centroTrabalhoListStore.search.isEmpty
                                ? translation.messages.nenhumEntidadeEncontrado(translation.titles.centroDeTrabalho)
                                : translation.messages.naoHaResultadosParaPesquisa,
                            style: AnaTextStyles.grey20Px,
                          ),
                        ),
                      } else if (centroTrabalhoListStore.search.isEmpty) ...{
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: Text(
                            translation.titles.ultimosCentrosAcessados,
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
                              return CentroTrabalhoItemWidget(
                                key: ValueKey('${value.centroTrabalho.codigo} - ${value.centroTrabalho.nome}'),
                                centroTrabalho: value.centroTrabalho,
                                deletarCentroTrabalhoStore: value.deletarStore,
                                centroTrabalhoListStore: centroTrabalhoListStore,
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
            CustomTextButton(title: translation.fields.voltar, onPressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path)),
            const SizedBox(width: 12),
            CustomPrimaryButton(
              title: translation.fields.criarCentro,
              onPressed: () => Modular.to.pushNamed(
                NavigationRouter.centrosDeTrabalhosModule.createPath,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
