// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;

import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
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
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_confirmacao_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_dados_basicos_form_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_painel_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_periodo_form_widget.dart';

class DesktopRoteiroVisualizarPage extends StatefulWidget {
  final RoteiroListStore roteiroListStore;
  final InserirEditarRoteiroStore inserirEditarRoteiroStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetFichaTecnicaStore getFichaTecnicaStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetProdutoStore getProdutoStore;
  final GetUnidadeStore getUnidadeStore;
  final GetMaterialStore getMaterialStore;
  final RoteiroController roteiroController;
  final OperacaoController operacaoController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final GlobalKey<FormState> dadosBasicosformKey;

  const DesktopRoteiroVisualizarPage({
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
    required this.roteiroController,
    required this.operacaoController,
    required this.scaffoldController,
    required this.connectionStore,
    required this.dadosBasicosformKey,
  }) : super(key: key);

  @override
  State<DesktopRoteiroVisualizarPage> createState() => _DesktopRoteiroVisualizarPageState();
}

class _DesktopRoteiroVisualizarPageState extends State<DesktopRoteiroVisualizarPage> {
  RoteiroListStore get roteiroListStore => widget.roteiroListStore;
  InserirEditarRoteiroStore get inserirEditarRoteiroStore => widget.inserirEditarRoteiroStore;
  GetCentroDeTrabalhoStore get getCentroDeTrabalhoStore => widget.getCentroDeTrabalhoStore;
  GetFichaTecnicaStore get getFichaTecnicaStore => widget.getFichaTecnicaStore;
  GetGrupoDeRecursoStore get getGrupoDeRecursoStore => widget.getGrupoDeRecursoStore;
  GetGrupoDeRestricaoStore get getGrupoDeRestricaoStore => widget.getGrupoDeRestricaoStore;
  GetProdutoStore get getProdutoStore => widget.getProdutoStore;
  GetUnidadeStore get getUnidadeStore => widget.getUnidadeStore;
  GetMaterialStore get getMaterialStore => widget.getMaterialStore;
  RoteiroController get roteiroController => widget.roteiroController;
  OperacaoController get operacaoController => widget.operacaoController;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  GlobalKey<FormState> get dadosBasicosformKey => widget.dadosBasicosformKey;

  late RoteiroAggregate roteiroOld;

  @override
  void initState() {
    super.initState();

    roteiroOld = roteiroController.roteiro.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        return CustomScaffold.titleString(
          roteiroOld.descricao.value,
          controller: scaffoldController,
          alignment: Alignment.centerLeft,
          tabStatusButtons: [
            TabStatusButton(
              title: translation.fields.dadosBasicos,
              select: roteiroController.pageIndex == 0,
              onTap: () => roteiroController.pageIndex = 0,
            ),
            TabStatusButton(
              title: translation.fields.periodoDeVigencia,
              select: roteiroController.pageIndex == 1,
              onTap: () => roteiroController.pageIndex = 1,
            ),
            TabStatusButton(
              title: translation.fields.operacoes,
              select: roteiroController.pageIndex == 2,
              onTap: () => roteiroController.pageIndex = 2,
            ),
            TabStatusButton(
              title: translation.fields.confirmacao,
              select: roteiroController.pageIndex == 3,
              onTap: () => roteiroController.pageIndex = 3,
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 670),
              child: PageView(
                key: ValueKey(roteiroController.pageIndex),
                controller: PageController(initialPage: roteiroController.pageIndex),
                children: [
                  DesktopDadosBasicosFormWidget(
                    roteiroController: roteiroController,
                    getProdutoStore: getProdutoStore,
                    getFichaTecnicaStore: getFichaTecnicaStore,
                    getUnidadeStore: getUnidadeStore,
                    formKey: dadosBasicosformKey,
                  ),
                  DesktopPeriodoFormWidget(roteiroController: roteiroController),
                  DesktopOperacaoPanelWidget(
                    roteiroController: roteiroController,
                    operacaoController: operacaoController,
                    getUnidadeStore: getUnidadeStore,
                    getCentroDeTrabalhoStore: getCentroDeTrabalhoStore,
                    getProdutoStore: getProdutoStore,
                    getMaterialStore: getMaterialStore,
                    getGrupoDeRecursoStore: getGrupoDeRecursoStore,
                    getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
                  ),
                  DesktopConfirmacaoWidget(roteiroController: roteiroController),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Visibility(
            visible: roteiroOld != roteiroController.roteiro,
            child: TripleBuilder<InserirEditarRoteiroStore, RoteiroAggregate?>(
              store: inserirEditarRoteiroStore,
              builder: (context, triple) {
                final error = triple.error;

                if (!triple.isLoading && error != null && error is Failure) {
                  Asuka.showDialog(
                    barrierColor: Colors.black38,
                    builder: (context) {
                      return ErrorModal(errorMessage: (triple.error as Failure).errorMessage ?? '');
                    },
                  );
                }

                final roteiro = triple.state;
                if (roteiro != null && roteiro != RoteiroAggregate.empty() && roteiro != roteiroOld && !triple.isLoading) {
                  Asuka.showSnackBar(
                    SnackBar(
                      content: Text(
                        translation.messages.editouUmEntidadeComSucesso(translation.fields.roteiro),
                        style: AnaTextStyles.grey14Px.copyWith(fontSize: 15, color: Colors.white, letterSpacing: 0.25),
                      ),
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.87),
                      behavior: SnackBarBehavior.floating,
                      width: 635,
                    ),
                  );

                  roteiroListStore.editarRoteiro(roteiro);

                  roteiroController.roteiro = roteiro;
                  setState(() {
                    roteiroOld = roteiro;
                  });
                }

                return ContainerNavigationBarWidget(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                        title: translation.fields.cancelar,
                        isEnabled: !triple.isLoading,
                        onPressed: () {
                          showDialog(
                            context: context,
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
                        },
                      ),
                      const SizedBox(width: 12),
                      CustomPrimaryButton(
                        title: translation.fields.salvar,
                        isLoading: triple.isLoading,
                        onPressed: () => inserirEditarRoteiroStore.editarRoteiro(roteiroController.roteiro),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
