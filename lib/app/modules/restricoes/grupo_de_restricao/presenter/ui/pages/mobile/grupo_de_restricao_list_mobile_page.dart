import 'package:ana_l10n/ana_l10n.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/list_tile_widget.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/grupo_de_restricao_list_store.dart';

class GrupoDeRestricaoListMobilePage extends StatelessWidget {
  final GrupoDeRestricaoListStore grupoDeRestricaoStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRestricaoListMobilePage({
    Key? key,
    required this.grupoDeRestricaoStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.titleString(
      context.l10n.materiaisPcpGruposDeRestricao,
      alignment: Alignment.centerLeft,
      controller: scaffoldController,
      onIconTap: () => Modular.to.pop(),
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PesquisaFormFieldWidget(
              label: context.l10n.materiaisPcpPesquisa,
              controller: grupoDeRestricaoStore.pesquisaController,
              onChanged: (value) => grupoDeRestricaoStore.getList(search: value),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ScopedBuilder<GrupoDeRestricaoListStore, List<GrupoDeRestricaoEntity>>(
                store: grupoDeRestricaoStore,
                onLoading: (_) => const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue)),
                onError: (context, error) => Container(),
                onState: (_, state) {
                  List<Widget> widgets = [];

                  if (state.isEmpty) {
                    widgets.add(
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            grupoDeRestricaoStore.pesquisaController.text.isEmpty
                                ? context.l10n
                                    .materiaisPcpNenhumaEntidadeEncontradaMasculino(context.l10n.materiaisPcpGrupoDeRestricao.toLowerCase())
                                : context.l10n.materiaisPcpNaoHaResultadosParaPesquisa,
                            style: AnaTextStyles.grey20Px,
                          ),
                        ),
                      ),
                    );
                  } else {
                    if (grupoDeRestricaoStore.pesquisaController.text.isEmpty) {
                      widgets.add(
                        Text(
                          context.l10n.materiaisPcpUltimosGruposAcessados,
                          style: AnaTextStyles.boldDarkGrey16Px.copyWith(fontSize: 18),
                        ),
                      );
                    }

                    widgets.add(
                      Expanded(
                        child: _GrupoDeRestricaosList(
                          gruposDeRestricaos: state,
                          store: grupoDeRestricaoStore,
                        ),
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widgets,
                  );
                },
              ),
            )
          ],
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
      ),
    );
  }
}

class _GrupoDeRestricaosList extends StatelessWidget {
  final GrupoDeRestricaoListStore store;
  final List<GrupoDeRestricaoEntity> gruposDeRestricaos;

  const _GrupoDeRestricaosList({
    Key? key,
    required this.gruposDeRestricaos,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: ListView(
        shrinkWrap: true,
        children: gruposDeRestricaos.map((grupoDeRestricao) {
          return ListTileWidget(
            title: '${grupoDeRestricao.codigo} - ${grupoDeRestricao.descricao}',
            subtitle: '${context.l10n.materiaisPcpTipoDeRestricao}: ${grupoDeRestricao.tipo.description}',
            onTap: () async {
              await Modular.to.pushNamed('./${grupoDeRestricao.id}');

              store.getList(
                search: store.pesquisaController.text,
                delay: Duration.zero,
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
