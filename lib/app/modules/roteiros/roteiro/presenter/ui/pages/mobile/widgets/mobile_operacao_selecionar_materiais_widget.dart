// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';

class MobileOperacaoSelecionarMateriaisWidget extends StatefulWidget {
  final List<ProdutoEntity> produtos;
  final List<ProdutoEntity> produtosFichaTecnica;
  final GetProdutoStore getProdutoStore;

  const MobileOperacaoSelecionarMateriaisWidget({
    Key? key,
    required this.produtos,
    required this.produtosFichaTecnica,
    required this.getProdutoStore,
  }) : super(key: key);

  @override
  State<MobileOperacaoSelecionarMateriaisWidget> createState() => _MobileOperacaoSelecionarMateriaisWidgetState();
}

class _MobileOperacaoSelecionarMateriaisWidgetState extends State<MobileOperacaoSelecionarMateriaisWidget> {
  List<ProdutoEntity> get produtos => widget.produtos;

  @override
  void initState() {
    super.initState();
    widget.getProdutoStore.getList(search: '');
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Dialog.fullscreen(
      child: Container(
        width: 550,
        height: 510,
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translation.titles.adicionarMateriais,
              style: themeData.textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            TextFormFieldWidget(
              label: '',
              prefix: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: colorTheme?.icons,
              ),
              onChanged: (value) => widget.getProdutoStore.getList(search: value),
            ),
            Expanded(
              child: ScopedBuilder<GetProdutoStore, List<ProdutoEntity>>(
                store: widget.getProdutoStore,
                onLoading: (context) => const Center(child: CircularProgressIndicator()),
                onState: (context, state) {
                  final listProduto = state.where((produto) => !widget.produtosFichaTecnica.contains(produto)).toList();
                  return ListView.builder(
                    itemCount: listProduto.length,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemBuilder: (context, index) {
                      final produto = listProduto[index];
                      return CheckboxListTile(
                        value: produtos.contains(produto),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(produto.nome),
                        onChanged: (value) {
                          if (value != null && value) {
                            produtos.add(produto);
                          } else {
                            if (produtos.contains(produto)) {
                              produtos.remove(produto);
                            }
                          }
                          setState(() {});
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                  title: translation.fields.cancelar,
                  onPressed: () => Navigator.of(context).pop(null),
                ),
                const SizedBox(width: 12),
                CustomPrimaryButton(
                  title: translation.fields.adicionar,
                  onPressed: () => Navigator.of(context).pop(produtos),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
