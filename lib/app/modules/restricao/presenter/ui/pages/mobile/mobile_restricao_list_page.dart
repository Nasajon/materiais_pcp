// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/state/restricao_state.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/ui/widgets/restricao_item_widget.dart';

class MobileRestricaoListPage extends StatelessWidget {
  final RestricaoListStore restricaoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const MobileRestricaoListPage({
    Key? key,
    required this.restricaoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;

    return CustomScaffold.titleString(
      translation.titles.restricoesSecundarias,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
      ],
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 635),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              ScopedBuilder<RestricaoListStore, List<RestricaoState>>(
                onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                onError: (context, error) => Container(),
                onState: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: PesquisaFormFieldWidget(
                          label: translation.messages.avisoPesquisarPorNomeOuPalavraChave,
                          initialValue: restricaoListStore.search,
                          onChanged: (value) {
                            restricaoListStore.search = value;
                            restricaoListStore.getListRestricao();
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (state.isEmpty) ...{
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                          child: Text(
                            restricaoListStore.search.isEmpty
                                ? translation.messages.nenhumaEntidadeEncontrada(translation.fields.restricao)
                                : translation.messages.naoHaResultadosParaPesquisa,
                            style: AnaTextStyles.grey20Px,
                          ),
                        ),
                      },
                      if (restricaoListStore.search.isEmpty) ...{
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: Text(
                            translation.titles.ultimasRestricoesAcessadas,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 32),
                      },
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Column(
                          children: state.map(
                            (state) {
                              return RestricaoItemWidget(
                                restricao: state.restricao,
                                deletarRestricaoStore: state.deletarStore,
                                restricaoListStore: restricaoListStore,
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
              onPressed: () => checkPreviousRouteWeb(NavigationRouter.appModule.path),
            ),
            const SizedBox(width: 12),
            CustomPrimaryButton(
              title: translation.fields.criarRestricao,
              onPressed: () async {
                await Modular.to.pushNamed(NavigationRouter.restricoesModule.createPath);
                restricaoListStore.getListRestricao();
              },
            )
          ],
        ),
      ),
    );
  }
}
