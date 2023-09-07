// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';

class DesktopOperacaoSelecionarMateriaisWidget extends StatefulWidget {
  final GetProdutoStore getProdutoStore;

  const DesktopOperacaoSelecionarMateriaisWidget({
    Key? key,
    required this.getProdutoStore,
  }) : super(key: key);

  @override
  State<DesktopOperacaoSelecionarMateriaisWidget> createState() => _DesktopOperacaoSelecionarMateriaisWidgetState();
}

class _DesktopOperacaoSelecionarMateriaisWidgetState extends State<DesktopOperacaoSelecionarMateriaisWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.getProdutoStore.getList(search: '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Dialog(
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
            ),
            Expanded(
              child: ScopedBuilder<GetProdutoStore, List<ProdutoEntity>>(
                store: widget.getProdutoStore,
                onLoading: (context) => const Center(child: CircularProgressIndicator()),
                onState: (context, state) {
                  return ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      final produto = state[index];
                      return CheckboxListTile(
                        value: false,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(produto.nome),
                        onChanged: (value) {},
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
