import 'package:ana_l10n/ana_l10n.dart';
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/restricao_list_store.dart';

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
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      l10n.titles.restricoesSecundarias,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      onIconTap: () => Modular.to.pop(),
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
              PesquisaFormFieldWidget(
                label: context.l10n.materiaisPcpPesquisa,
                onChanged: (value) => restricaoListStore.search = value,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ScopedBuilder<RestricaoListStore, List<RestricaoAggregate>>(
                  onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                  onError: (context, error) => Container(),
                  onState: (context, state) {
                    final createRestricaoButton = Center(
                      child: CustomPrimaryButton(
                        title: context.l10n.materiaisPcpCriarRestricao,
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
                              restricaoListStore.search.isEmpty
                                  ? context.l10n
                                      .materiaisPcpNenhumaEntidadeEncontradaMasculino(context.l10n.materiaisPcpRestricao.toLowerCase())
                                  : context.l10n.materiaisPcpNaoHaResultadosParaPesquisa,
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
                        if (restricaoListStore.search.isEmpty) ...{
                          Text(
                            context.l10n.materiaisPcpUltimosRestricoesAcessados,
                            style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 40),
                        },
                        Flexible(
                          child: ListView(
                            children: [
                              ...state.map((restricao) {
                                return ListTileWidget(
                                  title: '${restricao.codigo?.toText} - ${restricao.descricao.value}',
                                  subtitle: '${context.l10n.materiaisPcpTipoLabel}: ${restricao.grupoDeRestricao?.tipo.name}',
                                  trailing: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: colorTheme?.icons,
                                    ),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        Modular.to.pushNamed('./${restricao.id}/visualizar');
                                      } else {}
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem<int>(
                                          value: 1,
                                          child: Text(l10n.fields.visualizar),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 2,
                                          child: Text(l10n.fields.excluir),
                                        ),
                                      ];
                                    },
                                  ),
                                  onTap: () => Modular.to.pushNamed('./new'),
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
