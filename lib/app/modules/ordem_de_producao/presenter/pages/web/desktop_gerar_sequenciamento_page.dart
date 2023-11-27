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

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final [pageIndex] = context.select(() => [sequenciamentoController.pageIndex]);

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
                StepperComponent(textInfo: translation.fields.restricoes),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TripleBuilder<GerarSequenciamentoStore, SequenciamentoAggregate>(
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
            // Modular.to.pop();
          }

          return ContainerNavigationBarWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                  title: translation.fields.cancelar,
                  isEnabled: !triple.isLoading,
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                CustomPrimaryButton(
                  title: translation.fields.sequenciarOperacoes,
                  isEnabled: !triple.isLoading,
                  isLoading: triple.isLoading,
                  onPressed: () => gerarSequenciamentoStore.gerarSequenciamento(sequenciamentoController.sequenciamentoDTO),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
