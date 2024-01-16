// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_sequenciamento_grafico_gantt_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_sequenciamento_recursos_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_sequenciamento_restricoes_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_sequenciamento_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_table_ordem_de_producao_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/gerar_sequenciamento_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_cliente_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/inserir_editar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/sequenciar_ordem_de_producao_store.dart';

class DesktopGerarSequenciamentoPage extends StatefulWidget {
  final GerarSequenciamentoStore gerarSequenciamentoStore;
  final ConfirmarSequenciamentoStore confirmarSequenciamentoStore;
  final InserirEditarOrdemDeProducaoStore inserirEditarOrdemDeProducaoStore;
  final GetProdutoStore getProdutoStore;
  final GetRoteiroStore getRoteiroStore;
  final GetClienteStore getClienteStore;
  final GetOperacaoStore getOperacaoStore;
  final GetOrdemDeProducaoStore getOrdemDeProducaoStore;
  final SequenciamentoController sequenciamentoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;
  final OrdemDeProducaoController ordemDeProducaoController;

  const DesktopGerarSequenciamentoPage({
    Key? key,
    required this.gerarSequenciamentoStore,
    required this.confirmarSequenciamentoStore,
    required this.inserirEditarOrdemDeProducaoStore,
    required this.getProdutoStore,
    required this.getRoteiroStore,
    required this.getClienteStore,
    required this.getOperacaoStore,
    required this.getOrdemDeProducaoStore,
    required this.sequenciamentoController,
    required this.connectionStore,
    required this.scaffoldController,
    required this.ordemDeProducaoController,
  }) : super(key: key);

  @override
  State<DesktopGerarSequenciamentoPage> createState() => _DesktopGerarSequenciamentoPageState();
}

class _DesktopGerarSequenciamentoPageState extends State<DesktopGerarSequenciamentoPage> {
  GerarSequenciamentoStore get gerarSequenciamentoStore => widget.gerarSequenciamentoStore;
  ConfirmarSequenciamentoStore get confirmarSequenciamentoStore => widget.confirmarSequenciamentoStore;
  InserirEditarOrdemDeProducaoStore get inserirEditarOrdemDeProducaoStore => widget.inserirEditarOrdemDeProducaoStore;
  GetProdutoStore get getProdutoStore => widget.getProdutoStore;
  GetRoteiroStore get getRoteiroStore => widget.getRoteiroStore;
  GetClienteStore get getClienteStore => widget.getClienteStore;
  GetOperacaoStore get getOperacaoStore => widget.getOperacaoStore;
  GetOrdemDeProducaoStore get getOrdemDeProducaoStore => widget.getOrdemDeProducaoStore;
  SequenciamentoController get sequenciamentoController => widget.sequenciamentoController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  OrdemDeProducaoController get ordemDeProducaoController => widget.ordemDeProducaoController;

  late Disposer operacoesDisposer;
  late Disposer gerarSequenciamentoDisposer;
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
        sequenciamentoController.addOperacao(operacoes);
        containsRestricoesNotifier.value = sequenciamentoController.restricaoIds.isNotEmpty;
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
    confirmarSequenciamentoDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [sequenciamentoController.pageIndex]);

    final pageIndex = sequenciamentoController.pageIndex;

    return ValueListenableBuilder(
      valueListenable: containsRestricoesNotifier,
      builder: (_, containsRestricoes, __) {
        return CustomScaffold.titleString(
          translation.titles.planejarOrdem,
          controller: scaffoldController,
          alignment: Alignment.centerLeft,
          onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.ordensDeProducoesModule.path),
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
                    StepperComponent(textInfo: translation.fields.dadosGerais),
                    StepperComponent(textInfo: translation.fields.recursos),
                    if (containsRestricoes) StepperComponent(textInfo: translation.fields.restricoes),
                    StepperComponent(textInfo: translation.fields.resultado),
                  ],
                ),
                const SizedBox(width: 60),
                Container(
                  constraints: const BoxConstraints(maxWidth: 670),
                  child: PageView(
                    key: ValueKey(pageIndex),
                    controller: PageController(initialPage: pageIndex),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      DesktopTableOrdemDeProducaoWidget(
                        sequenciamentoController: sequenciamentoController,
                        ordemDeProducaoController: ordemDeProducaoController,
                        getRoteiroStore: getRoteiroStore,
                        getProdutoStore: getProdutoStore,
                        getClienteStore: getClienteStore,
                        getOperacaoStore: getOperacaoStore,
                        getOrdemDeProducaoStore: getOrdemDeProducaoStore,
                        inserirEditarOrdemDeProducaoStore: inserirEditarOrdemDeProducaoStore,
                      ),
                      DesktopSequenciamentoRecursosWidget(
                        getOperacaoStore: getOperacaoStore,
                        sequenciamentoController: sequenciamentoController,
                      ),
                      if (containsRestricoes)
                        DesktopSequenciamentoRestricoesWidget(
                          getOperacaoStore: getOperacaoStore,
                          sequenciamentoController: sequenciamentoController,
                        ),
                      DesktopSquenciamentoWidget(sequenciamentoController: sequenciamentoController)
                    ],
                  ),
                ),
              ],
            ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: ((containsRestricoes && pageIndex > 2) || (!containsRestricoes && pageIndex > 1)) &&
                          sequenciamentoController.sequenciamento != SequenciamentoAggregate.empty(),
                      child: CustomTextButton(
                        title: translation.fields.visualizarEmGrafico,
                        isEnabled: !isLoading,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog.fullscreen(
                                child: DesktopSequenciamentoGraficoGantt(
                                  sequenciamentoController: sequenciamentoController,
                                  connectionStore: connectionStore,
                                  scaffoldController: scaffoldController,
                                ),
                              );
                            },
                          );
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
                        if ((pageIndex < 2 && containsRestricoes) || pageIndex < 1) {
                          if (pageIndex == 0) {
                            sequenciamentoController.pageIndex = pageIndex + 1;
                          } else if (pageIndex != 0) {
                            sequenciamentoController.pageIndex = pageIndex + 1;
                          }
                        } else if ((containsRestricoes && pageIndex == 2) || (!containsRestricoes && pageIndex == 1)) {
                          gerarSequenciamentoStore.gerarSequenciamento(sequenciamentoController.sequenciamentoDTO);
                        } else {
                          confirmarSequenciamentoStore.confirmarSequenciamentoOrdemDeProducao(sequenciamentoController.sequenciamento);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
