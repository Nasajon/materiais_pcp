// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_card_operacao_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_card_ordem_producao_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/gerar_sequenciamento_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';

class DesktopGerarSequenciamentoPage extends StatefulWidget {
  final GerarSequenciamentoStore gerarSequenciamentoStore;
  final GetOperacaoStore getOperacaoStore;
  final SequenciamentoController sequenciamentoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;
  final OrdemDeProducaoController ordemDeProducaoController;

  const DesktopGerarSequenciamentoPage({
    Key? key,
    required this.gerarSequenciamentoStore,
    required this.getOperacaoStore,
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
  GetOperacaoStore get getOperacaoStore => widget.getOperacaoStore;
  SequenciamentoController get sequenciamentoController => widget.sequenciamentoController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  OrdemDeProducaoController get ordemDeProducaoController => widget.ordemDeProducaoController;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return CustomScaffold.titleString(
      translation.titles.planejarOrdem,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 686),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DesktopCardOrdemProducaoWidget(ordemDeProducao: ordemDeProducaoController.ordemDeProducao),
                const SizedBox(height: 20),
                Text(
                  translation.fields.operacoes,
                  style: themeData.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                ScopedBuilder<GetOperacaoStore, List<OperacaoAggregate>>(
                  store: getOperacaoStore,
                  onLoading: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  onState: (context, state) {
                    return Column(
                      children: [
                        ...state
                            .map(
                              (operacao) => DesktopCardOperacaoWidget(
                                operacao: operacao,
                                sequenciamentoController: sequenciamentoController,
                              ),
                            )
                            .toList(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
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
