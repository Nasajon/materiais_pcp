// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
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

class DesktopTableOrdemDeProducaoWidget extends StatelessWidget {
  final SequenciamentoController sequenciamentoController;
  final OrdemDeProducaoController ordemDeProducaoController;
  final GetRoteiroStore getRoteiroStore;
  final GetProdutoStore getProdutoStore;
  final GetClienteStore getClienteStore;
  final GetOperacaoStore getOperacaoStore;
  final GetOrdemDeProducaoStore getOrdemDeProducaoStore;

  const DesktopTableOrdemDeProducaoWidget({
    Key? key,
    required this.sequenciamentoController,
    required this.ordemDeProducaoController,
    required this.getRoteiroStore,
    required this.getProdutoStore,
    required this.getClienteStore,
    required this.getOperacaoStore,
    required this.getOrdemDeProducaoStore,
  }) : super(key: key);

  void showOrdemDeProducaoForm(OrdemDeProducaoAggregate ordemDeProducao) async {
    final formKey = GlobalKey<FormState>();
    ordemDeProducaoController.ordemDeProducao = ordemDeProducao;

    await Asuka.showDialog(builder: (context) {
      return AlertDialog(
        actions: [
          CustomTextButton(
            title: translation.fields.cancelar,
            onPressed: () => Navigator.pop(context),
          ),
          CustomPrimaryButton(
            title: translation.fields.salvar,
            onPressed: () {
              final currentState = formKey.currentState;
              if (currentState!.validate()) {
                sequenciamentoController.atualizarOrdemDeProducao(ordemDeProducaoController.ordemDeProducao);
                Navigator.pop(context);
              }
            },
          ),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            DesktopOrdemDeProducaoFormWidget(
              ordemDeProducaoController: ordemDeProducaoController,
              getRoteiroStore: getRoteiroStore,
              getProdutoStore: getProdutoStore,
              getClienteStore: getClienteStore,
              getOperacaoStore: getOperacaoStore,
              formKey: formKey,
            ),
          ],
        ),
      );
    });
  }

  void showSearchOrdemDeProducao() async {
    final response = await Asuka.showDialog(builder: (context) {
      return DesktopSearchOrdemDeProducaoWidget(
        listOrdemDeProducao: sequenciamentoController.listOrdemDeProducao,
        getOrdemDeProducaoStore: getOrdemDeProducaoStore,
      );
    });

    if (response != null && response is List<OrdemDeProducaoAggregate>) {
      sequenciamentoController.addOrdemDeProducao(response);
      getOperacaoStore.getList(response.map((ordem) => ordem.roteiro.id).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return RxBuilder(
      builder: (_) {
        final listOrdemDeProducao = sequenciamentoController.listOrdemDeProducao;

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
                          )
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
