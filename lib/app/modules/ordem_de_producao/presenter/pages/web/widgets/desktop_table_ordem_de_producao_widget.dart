// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/table/pcp_table.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_ordem_de_producao_form_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_search_ordem_de_producao_widget.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_cliente_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/inserir_editar_ordem_de_producao_store.dart';

class DesktopTableOrdemDeProducaoWidget extends StatefulWidget {
  final SequenciamentoController sequenciamentoController;
  final OrdemDeProducaoController ordemDeProducaoController;
  final InserirEditarOrdemDeProducaoStore inserirEditarOrdemDeProducaoStore;
  final GetRoteiroStore getRoteiroStore;
  final GetProdutoStore getProdutoStore;
  final GetClienteStore getClienteStore;
  final GetOperacaoStore getOperacaoStore;
  final GetOrdemDeProducaoStore getOrdemDeProducaoStore;

  const DesktopTableOrdemDeProducaoWidget({
    Key? key,
    required this.sequenciamentoController,
    required this.ordemDeProducaoController,
    required this.inserirEditarOrdemDeProducaoStore,
    required this.getRoteiroStore,
    required this.getProdutoStore,
    required this.getClienteStore,
    required this.getOperacaoStore,
    required this.getOrdemDeProducaoStore,
  }) : super(key: key);

  @override
  State<DesktopTableOrdemDeProducaoWidget> createState() => _DesktopTableOrdemDeProducaoWidgetState();
}

class _DesktopTableOrdemDeProducaoWidgetState extends State<DesktopTableOrdemDeProducaoWidget> {
  InserirEditarOrdemDeProducaoStore get inserirEditarOrdemDeProducaoStore => widget.inserirEditarOrdemDeProducaoStore;

  void showOrdemDeProducaoForm(OrdemDeProducaoAggregate ordemDeProducao) async {
    final formKey = GlobalKey<FormState>();
    widget.ordemDeProducaoController.ordemDeProducao = ordemDeProducao;

    await Asuka.showDialog(
      builder: (context) {
        return TripleBuilder<InserirEditarOrdemDeProducaoStore, OrdemDeProducaoAggregate>(
          store: inserirEditarOrdemDeProducaoStore,
          builder: (_, triple) {
            final isLoading = triple.isLoading;
            final state = triple.state;
            final error = triple.error;

            if (!triple.isLoading && error == Failure) {
              Asuka.showDialog(
                barrierColor: Colors.black38,
                builder: (context) {
                  return ErrorModal(errorMessage: error.errorMessage ?? '');
                },
              );
            }

            if (!isLoading && state != OrdemDeProducaoAggregate.empty() && state != ordemDeProducao) {
              widget.sequenciamentoController.atualizarOrdemDeProducao(widget.ordemDeProducaoController.ordemDeProducao);
              inserirEditarOrdemDeProducaoStore.update(OrdemDeProducaoAggregate.empty());
              Navigator.pop(context);
            }

            return AlertDialog(
              actions: [
                CustomTextButton(
                  title: translation.fields.cancelar,
                  isEnabled: !triple.isLoading,
                  onPressed: () => Navigator.pop(context),
                ),
                CustomPrimaryButton(
                  title: translation.fields.salvar,
                  isLoading: triple.isLoading,
                  onPressed: () {
                    final currentState = formKey.currentState;
                    if (currentState!.validate()) {
                      inserirEditarOrdemDeProducaoStore.atualizar(widget.ordemDeProducaoController.ordemDeProducao);
                    }
                  },
                ),
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  DesktopOrdemDeProducaoFormWidget(
                    ordemDeProducaoController: widget.ordemDeProducaoController,
                    getRoteiroStore: widget.getRoteiroStore,
                    getProdutoStore: widget.getProdutoStore,
                    getClienteStore: widget.getClienteStore,
                    getOperacaoStore: widget.getOperacaoStore,
                    formKey: formKey,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showSearchOrdemDeProducao() async {
    final response = await Asuka.showDialog(builder: (context) {
      return DesktopSearchOrdemDeProducaoWidget(
        listOrdemDeProducao: widget.sequenciamentoController.listOrdemDeProducao,
        getOrdemDeProducaoStore: widget.getOrdemDeProducaoStore,
      );
    });

    if (response != null && response is List<OrdemDeProducaoAggregate>) {
      widget.sequenciamentoController.addOrdemDeProducao(response);
      widget.getOperacaoStore.getList(response.map((ordem) => ordem.roteiro.id).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return RxBuilder(
      builder: (_) {
        final listOrdemDeProducao = widget.sequenciamentoController.listOrdemDeProducao;

        return PCPTable(
            actions: [
              CustomLinkButton(
                title: translation.fields.adicionarOrdemDeProducao,
                style: themeData.textTheme.labelLarge?.copyWith(
                      color: colorTheme?.primary,
                      fontWeight: FontWeight.w700,
                    ) ??
                    TextStyle(),
                onPressed: showSearchOrdemDeProducao,
              )
            ],
            columns: [
              DataColumn(
                label: TextDataColumn(text: translation.fields.codigo),
              ),
              DataColumn(
                label: TextDataColumn(text: translation.fields.roteiro),
              ),
              DataColumn(
                label: TextDataColumn(text: translation.fields.produto),
              ),
              DataColumn(
                label: TextDataColumn(text: translation.fields.quantidade),
              ),
              DataColumn(
                label: TextDataColumn(text: translation.fields.previsaoDeEntrega),
              ),
              const DataColumn(
                label: TextDataColumn(text: ''),
              ),
            ],
            rows: listOrdemDeProducao.map((ordemDeProducao) {
              return DataRow(
                cells: [
                  DataCell(Text(ordemDeProducao.codigo.toText)),
                  DataCell(Text(ordemDeProducao.roteiro.nome)),
                  DataCell(Text(ordemDeProducao.produto.nome)),
                  DataCell(Text(ordemDeProducao.quantidade.formatDoubleToString(decimalDigits: ordemDeProducao.roteiro.unidade.decimal))),
                  DataCell(Text(ordemDeProducao.previsaoDeEntrega.dateFormat() ?? '')),
                  DataCell(Align(
                    alignment: Alignment.center,
                    child: PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: colorTheme?.icons,
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text(translation.fields.editar),
                            onTap: () => showOrdemDeProducaoForm(ordemDeProducao),
                          ),
                          PopupMenuItem(
                            child: Text(translation.fields.excluir),
                            onTap: () => widget.sequenciamentoController.deletarOrdemdeProducao(ordemDeProducao),
                          ),
                        ];
                      },
                    ),
                  )),
                ],
              );
            }).toList());
      },
    );
  }
}
