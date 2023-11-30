// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_ordem_de_producao_form_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_sequenciamento_recursos_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_sequenciamento_restricoes_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_sequenciamento_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/gerar_sequenciamento_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_cliente_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_roteiro_store.dart';

class DesktopGerarSequenciamentoPage extends StatefulWidget {
  final GerarSequenciamentoStore gerarSequenciamentoStore;
  final GetProdutoStore getProdutoStore;
  final GetRoteiroStore getRoteiroStore;
  final GetClienteStore getClienteStore;
  final GetOperacaoStore getOperacaoStore;
  final SequenciamentoController sequenciamentoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;
  final OrdemDeProducaoController ordemDeProducaoController;
  final GlobalKey<FormState> formKey;

  const DesktopGerarSequenciamentoPage({
    Key? key,
    required this.gerarSequenciamentoStore,
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
  State<DesktopGerarSequenciamentoPage> createState() => _DesktopGerarSequenciamentoPageState();
}

class _DesktopGerarSequenciamentoPageState extends State<DesktopGerarSequenciamentoPage> {
  GerarSequenciamentoStore get gerarSequenciamentoStore => widget.gerarSequenciamentoStore;
  GetProdutoStore get getProdutoStore => widget.getProdutoStore;
  GetRoteiroStore get getRoteiroStore => widget.getRoteiroStore;
  GetClienteStore get getClienteStore => widget.getClienteStore;
  GetOperacaoStore get getOperacaoStore => widget.getOperacaoStore;
  SequenciamentoController get sequenciamentoController => widget.sequenciamentoController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  OrdemDeProducaoController get ordemDeProducaoController => widget.ordemDeProducaoController;

  late Disposer operacoesDisposer;
  final containsRestricoesNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    operacoesDisposer = getOperacaoStore.observer(
      onState: (operacoes) {
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
  }

  @override
  void dispose() {
    operacoesDisposer();
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
                      DesktopOrdemDeProducaoFormWidget(
                        ordemDeProducaoController: ordemDeProducaoController,
                        getRoteiroStore: getRoteiroStore,
                        getProdutoStore: getProdutoStore,
                        getClienteStore: getClienteStore,
                        getOperacaoStore: getOperacaoStore,
                        formKey: widget.formKey,
                        padding: const EdgeInsets.symmetric(vertical: 6),
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
          bottomNavigationBar: TripleBuilder<GerarSequenciamentoStore, SequenciamentoAggregate>(
            key: ValueKey(pageIndex),
            store: gerarSequenciamentoStore,
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

              final sequenciamento = triple.state;
              if (!triple.isLoading &&
                  sequenciamento != SequenciamentoAggregate.empty() &&
                  sequenciamento != sequenciamentoController.sequenciamento) {
                sequenciamentoController.sequenciamento = sequenciamento;
                sequenciamentoController.pageIndex = pageIndex + 1;
              }

              var buttonPrimaryText = translation.fields.continuar;

              if (pageIndex == 2) {
                buttonPrimaryText = translation.fields.sequenciarOperacoes;
              }

              return ContainerNavigationBarWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: pageIndex > 0,
                      child: CustomTextButton(
                        title: translation.fields.voltar,
                        isEnabled: !triple.isLoading,
                        onPressed: () => sequenciamentoController.pageIndex = pageIndex - 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomPrimaryButton(
                      title: buttonPrimaryText,
                      isEnabled: !triple.isLoading,
                      isLoading: triple.isLoading,
                      onPressed: () {
                        if (pageIndex < 2) {
                          sequenciamentoController.pageIndex = pageIndex + 1;
                        } else if (pageIndex == 2) {
                          gerarSequenciamentoStore.gerarSequenciamento(sequenciamentoController.sequenciamentoDTO);
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
