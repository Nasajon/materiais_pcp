// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showDialog;
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_material_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_selecionar_materiais_widget.dart';

class DesktopOperacaoMaterialFormWidget extends StatefulWidget {
  final OperacaoController operacaoController;
  final GetMaterialStore getMaterialStore;
  final GetProdutoStore getProdutoStore;

  const DesktopOperacaoMaterialFormWidget({
    Key? key,
    required this.operacaoController,
    required this.getMaterialStore,
    required this.getProdutoStore,
  }) : super(key: key);

  @override
  State<DesktopOperacaoMaterialFormWidget> createState() => _DesktopOperacaoMaterialFormWidgetState();
}

class _DesktopOperacaoMaterialFormWidgetState extends State<DesktopOperacaoMaterialFormWidget> {
  Disposer? disposer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      disposer = widget.getMaterialStore.observer(
        onLoading: (loading) {
          setState(() {});
        },
        onState: (state) {
          final listMateriais = state;

          for (var material in widget.operacaoController.materiais) {
            if (listMateriais.map((material) => material.produto).toList().contains(material.produto)) {
              final index = listMateriais.indexWhere((element) => element.produto.id == material.produto.id);

              var novoMaterial = listMateriais[index];

              novoMaterial = novoMaterial.copyWith(
                disponivel: DoubleVO(novoMaterial.disponivel.value - material.disponivel.value),
                produtoAdicional: false,
              );

              listMateriais.setAll(index, [novoMaterial]);
            } else {
              final index = widget.operacaoController.materiais.indexWhere((element) => element.produto.id == material.produto.id);
              widget.operacaoController.materiais.setAll(index, [material.copyWith(produtoAdicional: true)]);
              listMateriais.add(material.copyWith(produtoAdicional: true));
            }
          }

          for (var material in widget.operacaoController.operacao.materiais) {
            final index = listMateriais.indexWhere((element) => element.produto.id == material.produto.id);

            if (widget.operacaoController.operacao != OperacaoAggregate.empty()) {
              listMateriais[index] = listMateriais[index].copyWith(quantidade: material.quantidade);

              listMateriais.setAll(index, [listMateriais[index]]);
            }
          }

          // final operacao = widget.operacaoController.operacao.copyWith(materiais: listMateriais);
          widget.operacaoController.operacao = widget.operacaoController.operacao.copyWith(materiais: listMateriais);
          setState(() {});
        },
      );
    });
  }

  @override
  void dispose() {
    disposer?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: colorTheme?.border ?? Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                translation.titles.materiais,
                style: themeData.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
              widget.getMaterialStore.triple.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: widget.operacaoController.operacao.materiais
                          .where((element) => element.disponivel.value > 0 || element.produtoAdicional)
                          .toList()
                          .map(
                            (material) => _CardMaterialWidget(
                              material: material,
                              operacaoController: widget.operacaoController,
                            ),
                          )
                          .toList(),
                    ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    translation.messages.mensagemNaoEncontrouMaterial,
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: CustomOutlinedButton(
                      title: translation.fields.adicionarMateriais,
                      onPressed: () async {
                        final responseModal = await showDialog(
                          context: context,
                          builder: (context) => DesktopOperacaoSelecionarMateriaisWidget(
                            produtosFichaTecnica: widget.operacaoController.operacao.materiais
                                .where((element) => !element.produtoAdicional)
                                .map((material) => material.produto)
                                .toList(),
                            produtos: widget.operacaoController.operacao.materiais
                                .where((element) => element.produtoAdicional)
                                .map((material) => material.produto)
                                .toList(),
                            getProdutoStore: widget.getProdutoStore,
                          ),
                        );

                        if (responseModal != null && responseModal is List<ProdutoEntity>) {
                          final materiais =
                              widget.operacaoController.operacao.materiais.where((material) => !material.produtoAdicional).toList();
                          final materiaisAdicionais =
                              widget.operacaoController.operacao.materiais.where((material) => material.produtoAdicional).toList();

                          materiaisAdicionais.removeWhere((adicional) => !responseModal.contains(adicional.produto));
                          responseModal.removeWhere(
                            (adicional) => materiaisAdicionais.map((material) => material.produto).toList().contains(adicional),
                          );

                          materiais
                            ..addAll(materiaisAdicionais)
                            ..addAll(
                              responseModal.map(
                                (produto) => MaterialEntity(
                                  fichaTecnicaId: null,
                                  produto: produto,
                                  unidade: produto.unidade ?? const UnidadeEntity(id: '', codigo: '', descricao: '', decimal: 0),
                                  disponivel: DoubleVO(null),
                                  quantidade: DoubleVO(null),
                                  produtoAdicional: true,
                                ),
                              ),
                            );

                          widget.operacaoController.operacao = widget.operacaoController.operacao.copyWith(materiais: materiais);

                          setState(() {});
                        }
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _CardMaterialWidget extends StatelessWidget {
  final OperacaoController operacaoController;
  final MaterialEntity material;

  const _CardMaterialWidget({
    Key? key,
    required this.operacaoController,
    required this.material,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorTheme?.background,
            border: Border.all(
              color: colorTheme?.border ?? Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            translation.fields.material,
                            style: themeData.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            material.produto.nome,
                            style: themeData.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            translation.fields.unidadeDeMedida,
                            style: themeData.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${material.unidade.descricao} - ${material.unidade.codigo}',
                            style: themeData.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Opacity(
                        opacity: !material.produtoAdicional ? 1 : 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              translation.fields.disponibilidade,
                              style: themeData.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              material.disponivel.formatDoubleToString(decimalDigits: material.unidade.decimal),
                              style: themeData.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: DoubleTextFormFieldWidget(
                  label: translation.fields.utilizar,
                  initialValue: material.quantidade.valueOrNull != null && material.quantidade.valueOrNull == 0
                      ? null
                      : material.quantidade.valueOrNull,
                  decimalDigits: material.unidade.decimal,
                  onChanged: (value) {
                    final novoMaterial = material.copyWith(quantidade: DoubleVO(value));
                    final index = operacaoController.operacao.materiais.indexWhere((element) => element.produto.id == material.produto.id);
                    final materiais = operacaoController.operacao.materiais;
                    materiais.setAll(index, [novoMaterial]);
                    operacaoController.operacao = operacaoController.operacao.copyWith(materiais: materiais);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
