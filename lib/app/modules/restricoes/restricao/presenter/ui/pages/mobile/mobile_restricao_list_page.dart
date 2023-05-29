// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/restricao_list_store.dart';

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
    final l10n = context.l10n;

    const horizontalPadding = 16.0;

    return CustomScaffold.titleString(l10n.materiaisPcpRestricoes,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: PesquisaFormFieldWidget(
                    label: context.l10n.materiaisPcpPesquisa,
                    onChanged: (value) => restricaoListStore.search = value,
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: ScopedBuilder<RestricaoListStore, List<RestricaoAggregate>>(
                    onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                    onError: (context, error) => Container(),
                    onState: (context, state) {
                      if (state.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                              child: Text(
                                restricaoListStore.search.isEmpty
                                    ? context.l10n
                                        .materiaisPcpNenhumaEntidadeEncontradaMasculino(context.l10n.materiaisPcpRestricao.toLowerCase())
                                    : context.l10n.materiaisPcpNaoHaResultadosParaPesquisa,
                                style: AnaTextStyles.grey20Px,
                              ),
                            ),
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (restricaoListStore.search.isEmpty) ...{
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                              child: Text(
                                context.l10n.materiaisPcpUltimosRestricoesAcessados,
                                style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                              ),
                            ),
                            const SizedBox(height: 32),
                          },
                          Flexible(
                            child: ListView.builder(
                              itemCount: state.length,
                              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
                              itemBuilder: (context, index) {
                                final restricao = state[index];

                                return ListTileWidget(
                                  title: '${restricao.codigo} - ${restricao.descricao}',
                                  subtitle: '${context.l10n.materiaisPcpTipoLabel}: ${restricao.grupoDeRestricao.tipo.name}',
                                  onTap: () {},
                                );
                              },
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
        bottomNavigationBar: ContainerNavigationBarWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(title: context.l10n.materiaisPcpVoltar, onPressed: () => Modular.to.pop()),
              const SizedBox(width: 12),
              CustomPrimaryButton(title: context.l10n.materiaisPcpCriarGrupo, onPressed: () => Modular.to.pushNamed('./new'))
            ],
          ),
        ));
  }
}
