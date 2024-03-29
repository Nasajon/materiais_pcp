// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/widgets/mobile_ordem_de_producao_form_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/widgets/mobile_sequenciamento_grafico_gantt_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/widgets/mobile_sequenciamento_recursos_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/widgets/mobile_sequenciamento_restricoes_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/widgets/mobile_sequenciamento_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/gerar_sequenciamento_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_cliente_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/inserir_editar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/sequenciar_ordem_de_producao_store.dart';

class MobileGerarSequenciamentoPage extends StatefulWidget {
  final GerarSequenciamentoStore gerarSequenciamentoStore;
  final ConfirmarSequenciamentoStore confirmarSequenciamentoStore;
  final InserirEditarOrdemDeProducaoStore inserirEditarOrdemDeProducaoStore;
  final GetProdutoStore getProdutoStore;
  final GetRoteiroStore getRoteiroStore;
  final GetClienteStore getClienteStore;
  final GetOperacaoStore getOperacaoStore;
  final SequenciamentoController sequenciamentoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;
  final OrdemDeProducaoController ordemDeProducaoController;
  final GlobalKey<FormState> formKey;

  const MobileGerarSequenciamentoPage({
    Key? key,
    required this.gerarSequenciamentoStore,
    required this.confirmarSequenciamentoStore,
    required this.inserirEditarOrdemDeProducaoStore,
    required this.getProdutoStore,
    required this.getRoteiroStore,
    required this.getClienteStore,
    required this.getOperacaoStore,
    required this.sequenciamentoController,
    required this.connectionStore,
    required this.scaffoldController,
    required this.ordemDeProducaoController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<MobileGerarSequenciamentoPage> createState() => _MobileGerarSequenciamentoPageState();
}

class _MobileGerarSequenciamentoPageState extends State<MobileGerarSequenciamentoPage> {
  GerarSequenciamentoStore get gerarSequenciamentoStore => widget.gerarSequenciamentoStore;
  ConfirmarSequenciamentoStore get confirmarSequenciamentoStore => widget.confirmarSequenciamentoStore;
  InserirEditarOrdemDeProducaoStore get inserirEditarOrdemDeProducaoStore => widget.inserirEditarOrdemDeProducaoStore;
  GetProdutoStore get getProdutoStore => widget.getProdutoStore;
  GetRoteiroStore get getRoteiroStore => widget.getRoteiroStore;
  GetClienteStore get getClienteStore => widget.getClienteStore;
  GetOperacaoStore get getOperacaoStore => widget.getOperacaoStore;
  SequenciamentoController get sequenciamentoController => widget.sequenciamentoController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  OrdemDeProducaoController get ordemDeProducaoController => widget.ordemDeProducaoController;

  late Disposer operacoesDisposer;
  late Disposer gerarSequenciamentoDisposer;
  late Disposer inserirEditarOrdemDeProducaoDisposer;
  late Disposer confirmarSequenciamentoDisposer;
  final containsRestricoesNotifier = ValueNotifier(false);
  final isLoadingNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    operacoesDisposer = getOperacaoStore.observer(
      onLoading: (value) => isLoadingNotifier.value = value,
      onError: (error) => showError(error),
      onState: (operacoes) {
        isLoadingNotifier.value = false;
        for (var operacao in operacoes) {
          for (var grupoDeRecurso in operacao.grupoDeRecursos) {
            for (var recurso in grupoDeRecurso.recursos) {
              containsRestricoesNotifier.value = recurso.grupoDeRestricoes.isNotEmpty;
              break;
            }
          }
        }
      },
    );

    inserirEditarOrdemDeProducaoDisposer = inserirEditarOrdemDeProducaoStore.observer(
      onLoading: (value) => isLoadingNotifier.value = value,
      onError: (error) => showError(error),
      onState: (state) {
        isLoadingNotifier.value = false;
        final ordemDeProducao = state;

        if (ordemDeProducao != OrdemDeProducaoAggregate.empty()) {
          ordemDeProducaoController.ordemDeProducao = ordemDeProducao;
          confirmarSequenciamentoStore.confirmarSequenciamentoOrdemDeProducao(sequenciamentoController.sequenciamento);
        }
      },
    );

    confirmarSequenciamentoDisposer = confirmarSequenciamentoStore.observer(
      onLoading: (value) => isLoadingNotifier.value = value,
      onError: (error) => showError(error),
      onState: (state) => checkPreviousRouteWeb(NavigationRouter.ordensDeProducoesModule.path),
    );

    gerarSequenciamentoDisposer = gerarSequenciamentoStore.observer(
      onLoading: (value) => isLoadingNotifier.value = value,
      onError: (error) => showError(error),
      onState: (sequenciamento) {
        isLoadingNotifier.value = false;
        if (sequenciamento != SequenciamentoAggregate.empty()) {
          sequenciamentoController.sequenciamento = sequenciamento;
          sequenciamentoController.pageIndex += 1;
        }
      },
    );
  }

  void showError(dynamic error) {
    isLoadingNotifier.value = false;
    Asuka.showDialog(
        barrierColor: Colors.black38,
        builder: (context) {
          return ErrorModal(errorMessage: (error as Failure).errorMessage ?? '');
        });
  }

  @override
  void dispose() {
    operacoesDisposer();
    gerarSequenciamentoDisposer();
    inserirEditarOrdemDeProducaoDisposer();
    confirmarSequenciamentoDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [sequenciamentoController.pageIndex]);

    final pageIndex = sequenciamentoController.pageIndex;

    return ValueListenableBuilder(
      valueListenable: containsRestricoesNotifier,
      builder: (context, containsRestricoes, _) {
        return CustomScaffold.titleString(
          translation.titles.planejarOrdem,
          controller: scaffoldController,
          alignment: Alignment.centerLeft,
          onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.ordensDeProducoesModule.path),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: HorizontalStepperWidget(
                  key: ValueKey(pageIndex),
                  initialValue: pageIndex,
                  steppers: [
                    StepperComponent(textInfo: translation.fields.dadosGerais),
                    StepperComponent(textInfo: translation.fields.recursos),
                    if (containsRestricoes) StepperComponent(textInfo: translation.fields.restricoes),
                    StepperComponent(textInfo: translation.fields.resultado),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Flexible(
                child: PageView(
                  key: ValueKey(pageIndex),
                  controller: PageController(initialPage: pageIndex),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    MobileOrdemDeProducaoFormWidget(
                      ordemDeProducaoController: ordemDeProducaoController,
                      getRoteiroStore: getRoteiroStore,
                      getProdutoStore: getProdutoStore,
                      getClienteStore: getClienteStore,
                      getOperacaoStore: getOperacaoStore,
                      formKey: widget.formKey,
                      padding: const EdgeInsets.all(16),
                    ),
                    MobileSequenciamentoRecursosWidget(
                      getOperacaoStore: getOperacaoStore,
                      sequenciamentoController: sequenciamentoController,
                    ),
                    if (containsRestricoes)
                      MobileSequenciamentoRestricoesWidget(
                        getOperacaoStore: getOperacaoStore,
                        sequenciamentoController: sequenciamentoController,
                      ),
                    MobileSquenciamentoWidget(sequenciamentoController: sequenciamentoController)
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: isLoadingNotifier,
            builder: (context, isLoading, _) {
              var buttonPrimaryText = translation.fields.continuar;

              if ((containsRestricoes && pageIndex == 2) || (!containsRestricoes && pageIndex == 1)) {
                buttonPrimaryText = translation.fields.sequenciarOperacoes;
              } else if ((containsRestricoes && pageIndex == 3) || (!containsRestricoes && pageIndex == 2)) {
                buttonPrimaryText = translation.fields.confirmacao;
              }

              return ContainerNavigationBarWidget(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: (Platform.isAndroid || Platform.isIOS) &&
                            ((containsRestricoes && pageIndex > 2) || (!containsRestricoes && pageIndex > 1)) &&
                            sequenciamentoController.sequenciamento != SequenciamentoAggregate.empty(),
                        child: CustomTextButton(
                          title: translation.fields.visualizarEmGrafico,
                          isEnabled: !isLoading,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog.fullscreen(
                                    child: MobileSequenciamentoGraficoGantt(
                                      sequenciamentoController: sequenciamentoController,
                                      connectionStore: connectionStore,
                                      scaffoldController: scaffoldController,
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Visibility(
                        visible: pageIndex > 0,
                        child: CustomTextButton(
                          title: translation.fields.voltar,
                          isEnabled: !isLoading,
                          onPressed: () => sequenciamentoController.pageIndex = pageIndex - 1,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomPrimaryButton(
                        title: buttonPrimaryText,
                        isEnabled: !isLoading,
                        isLoading: isLoading,
                        onPressed: () {
                          if (pageIndex < 2) {
                            if (pageIndex == 0 && widget.formKey.currentState != null && widget.formKey.currentState!.validate()) {
                              sequenciamentoController.pageIndex = pageIndex + 1;
                            } else if (pageIndex != 0) {
                              sequenciamentoController.pageIndex = pageIndex + 1;
                            }
                          } else if ((containsRestricoes && pageIndex == 2) || (!containsRestricoes && pageIndex == 1)) {
                            gerarSequenciamentoStore.gerarSequenciamento(sequenciamentoController.sequenciamentoDTO);
                          } else {
                            inserirEditarOrdemDeProducaoStore.atualizar(ordemDeProducaoController.ordemDeProducao);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
