// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/roteiro_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_material_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/inserir_editar_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/roteiro_list_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_dados_basicos_form_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_painel_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_periodo_form_widget.dart';

class DesktopRoteiroFormPage extends StatelessWidget {
  final RoteiroListStore roteiroListStore;
  final InserirEditarRoteiroStore inserirEditarRoteiroStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetFichaTecnicaStore getFichaTecnicaStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetProdutoStore getProdutoStore;
  final GetUnidadeStore getUnidadeStore;
  final GetMaterialStore getMaterialStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final RoteiroController roteiroController;
  final GlobalKey<FormState> dadosBasicosformKey;
  final GlobalKey<FormState> operacaoformKey;

  const DesktopRoteiroFormPage({
    Key? key,
    required this.roteiroListStore,
    required this.inserirEditarRoteiroStore,
    required this.getCentroDeTrabalhoStore,
    required this.getFichaTecnicaStore,
    required this.getGrupoDeRecursoStore,
    required this.getGrupoDeRestricaoStore,
    required this.getProdutoStore,
    required this.getUnidadeStore,
    required this.getMaterialStore,
    required this.scaffoldController,
    required this.connectionStore,
    required this.roteiroController,
    required this.dadosBasicosformKey,
    required this.operacaoformKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select(() => [
          roteiroController.roteiro,
          roteiroController.pageIndex,
        ]);

    final pageIndex = roteiroController.pageIndex;

    return CustomScaffold.titleString(
      translation.titles.criarEntidade(translation.fields.roteiro),
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalStepperWidget(
              key: ValueKey(pageIndex),
              initialValue: pageIndex,
              steppers: [
                StepperComponent(textInfo: translation.fields.dadosBasicos),
                StepperComponent(textInfo: translation.fields.periodoDeVigencia),
                StepperComponent(textInfo: translation.fields.operacoes),
                StepperComponent(textInfo: translation.fields.confirmacao),
              ],
            ),
            const SizedBox(width: 60),
            Container(
              constraints: const BoxConstraints(maxWidth: 670),
              child: PageView(
                key: ValueKey(pageIndex),
                controller: PageController(initialPage: pageIndex),
                children: [
                  DesktopDadosBasicosFormWidget(
                    roteiroController: roteiroController,
                    getProdutoStore: getProdutoStore,
                    getFichaTecnicaStore: getFichaTecnicaStore,
                    getUnidadeStore: getUnidadeStore,
                  ),
                  DesktopPeriodoFormWidget(roteiroController: roteiroController),
                  DesktopOperacaoPanelWidget(
                    roteiroController: roteiroController,
                    getUnidadeStore: getUnidadeStore,
                    getCentroDeTrabalhoStore: getCentroDeTrabalhoStore,
                    getProdutoStore: getProdutoStore,
                    getMaterialStore: getMaterialStore,
                    getGrupoDeRecursoStore: getGrupoDeRecursoStore,
                    getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
                  ),
                  Container(color: Colors.redAccent),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(
              title: translation.fields.cancelar,
              // isEnabled: !triple.isLoading,
              onPressed: () {
                if (roteiroController.roteiro != RoteiroAggregate.empty()) {
                  Asuka.showDialog(
                    barrierColor: Colors.black38,
                    builder: (context) {
                      return ConfirmationModalWidget(
                        title: translation.titles.descartarAlteracoes,
                        messages: translation.messages.descatarAlteracoesCriacaoEntidade,
                        titleCancel: translation.fields.descartar,
                        titleSuccess: translation.fields.continuar,
                        onCancel: () => Modular.to.pop(),
                      );
                    },
                  );
                } else {
                  Modular.to.pop();
                }
              },
            ),
            const SizedBox(width: 10),
            Visibility(
              visible: pageIndex > 0,
              child: CustomOutlinedButton(
                title: translation.fields.voltar,
                // isEnabled: !triple.isLoading,
                onPressed: () => roteiroController.pageIndex = pageIndex - 1,
              ),
            ),
            const SizedBox(width: 10),
            CustomPrimaryButton(
              title: pageIndex + 1 < 4 ? translation.fields.continuar : translation.fields.criar,
              onPressed: () => roteiroController.pageIndex = pageIndex + 1,
            ),
          ],
        ),
      ),
    );
  }
}
