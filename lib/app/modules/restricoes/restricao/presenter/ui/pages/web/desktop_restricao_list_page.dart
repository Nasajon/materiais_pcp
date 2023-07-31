import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/state/restricao_state.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/widgets/restricao_item_widget.dart';

class DesktopRestricaoListPage extends StatelessWidget {
  final RestricaoListStore restricaoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const DesktopRestricaoListPage({
    Key? key,
    required this.restricaoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    final createRestricaoButton = Center(
      child: CustomPrimaryButton(
        title: translation.titles.criarRestricaoSecundaria,
        onPressed: () async {
          await Modular.to.pushNamed('./new');
        },
      ),
    );

    final pesquisaWidget = [
      PesquisaFormFieldWidget(
        label: translation.messages.avisoPesquisarPorNomeOuPalavraChave,
        onChanged: (value) => restricaoListStore.search = value,
      ),
      const SizedBox(height: 40),
    ];

    return CustomScaffold.titleString(
      translation.titles.restricoesSecundarias,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
      ],
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 635),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: ScopedBuilder<RestricaoListStore, List<RestricaoState>>(
                  onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                  onError: (context, error) => Container(),
                  onState: (context, state) {
                    if (state.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...pesquisaWidget,
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              restricaoListStore.search.isEmpty
                                  ? translation.messages.nenhumaEntidadeEncontrada(translation.fields.restricao)
                                  : translation.messages.naoHaResultadosParaPesquisa,
                              style: AnaTextStyles.grey20Px,
                            ),
                          ),
                          createRestricaoButton,
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...pesquisaWidget,
                        if (restricaoListStore.search.isEmpty) ...{
                          Text(
                            translation.titles.ultimasRestricoesAcessadas,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 40),
                        },
                        Flexible(
                          child: ListView(
                            children: [
                              ...state.map((state) {
                                return RestricaoItemWidget(
                                  restricao: state.restricao,
                                  deletarRestricaoStore: state.deletarStore,
                                  restricaoListStore: restricaoListStore,
                                );
                              }).toList(),
                              const SizedBox(height: 16),
                              createRestricaoButton,
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
