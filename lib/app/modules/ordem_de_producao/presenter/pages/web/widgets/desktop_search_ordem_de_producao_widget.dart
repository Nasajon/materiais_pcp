// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/pesquisa_form_field_widget.dart';
import 'package:pcp_flutter/app/core/widgets/table/pcp_table.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_ordem_de_producao_store.dart';

class DesktopSearchOrdemDeProducaoWidget extends StatefulWidget {
  final List<OrdemDeProducaoAggregate> listOrdemDeProducao;
  final GetOrdemDeProducaoStore getOrdemDeProducaoStore;

  const DesktopSearchOrdemDeProducaoWidget({
    Key? key,
    required this.listOrdemDeProducao,
    required this.getOrdemDeProducaoStore,
  }) : super(key: key);

  @override
  State<DesktopSearchOrdemDeProducaoWidget> createState() => _DesktopSearchOrdemDeProducaoWidgetState();
}

class _DesktopSearchOrdemDeProducaoWidgetState extends State<DesktopSearchOrdemDeProducaoWidget> {
  final listOrdemDeProducaoNotifier = ValueNotifier(<OrdemDeProducaoAggregate>[]);
  final isLoadingNotifier = ValueNotifier(false);
  final List<OrdemDeProducaoAggregate> ordemDeProducaoSelecionados = [];

  late final Disposer getOrdemDeProducaoDisposer;

  @override
  void initState() {
    super.initState();

    widget.getOrdemDeProducaoStore.searchOrdensDeProducoes();

    getOrdemDeProducaoDisposer = widget.getOrdemDeProducaoStore.observer(
        onLoading: (value) => isLoadingNotifier.value = value,
        onError: (error) {},
        onState: (listOrdemDeProducao) {
          final ordens = [...listOrdemDeProducao];

          ordens.removeWhere(
            (ordem) => widget.listOrdemDeProducao.where((ordemProducao) => ordem.id == ordemProducao.id).isNotEmpty,
          );

          listOrdemDeProducaoNotifier.value = ordens;
        });
  }

  @override
  void dispose() {
    getOrdemDeProducaoDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ValueListenableBuilder(
        valueListenable: isLoadingNotifier,
        builder: (_, isLoading, __) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: PesquisaFormFieldWidget(
                    label: '',
                    onChanged: (value) => widget.getOrdemDeProducaoStore.searchOrdensDeProducoes(search: value),
                  ),
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder(
                  valueListenable: listOrdemDeProducaoNotifier,
                  builder: (_, listOrdemDeProducao, __) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: PCPTable(
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
                            label: TextDataColumn(text: translation.fields.previsaoDeEntrega),
                          ),
                        ],
                        rows: listOrdemDeProducao.map(
                          (ordemDeProducao) {
                            return DataRow(
                              selected: ordemDeProducaoSelecionados.contains(ordemDeProducao),
                              onSelectChanged: (value) {
                                if (value != null && value) {
                                  setState(() {
                                    ordemDeProducaoSelecionados.add(ordemDeProducao);
                                  });
                                } else {
                                  setState(() {
                                    ordemDeProducaoSelecionados.remove(ordemDeProducao);
                                  });
                                }
                              },
                              cells: [
                                DataCell(Text(ordemDeProducao.codigo.toText)),
                                DataCell(Text(ordemDeProducao.roteiro.nome)),
                                DataCell(Text(ordemDeProducao.produto.nome)),
                                DataCell(Text(ordemDeProducao.previsaoDeEntrega.dateFormat() ?? '')),
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    );
                  },
                ),
                if (isLoading)
                  const Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                        title: translation.fields.cancelar,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 10),
                      CustomPrimaryButton(
                        title: translation.fields.adicionar,
                        onPressed: () {
                          Navigator.of(context).pop(ordemDeProducaoSelecionados);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
