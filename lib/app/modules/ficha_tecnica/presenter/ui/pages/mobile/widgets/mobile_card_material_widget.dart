// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_produto_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/unidades_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/mobile/mobile_criar_editar_material_page.dart';

class MobileCardMaterialWidget extends StatefulWidget {
  final FichaTecnicaFormController fichaTecnicaFormController;
  final FichaTecnicaMaterialAggregate material;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;

  final ValueNotifier<bool> adaptiveModalNotifier;

  const MobileCardMaterialWidget({
    Key? key,
    required this.material,
    required this.adaptiveModalNotifier,
    required this.fichaTecnicaFormController,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  State<MobileCardMaterialWidget> createState() => _MobileCardMaterialWidgetState();
}

class _MobileCardMaterialWidgetState extends State<MobileCardMaterialWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void showModalCriarEditarMaterial() {
    widget.adaptiveModalNotifier.value = true;
    Asuka.showModalBottomSheet(
      isScrollControlled: true,
      builder: (context) {
        return MobileCriarEditarMaterialPage(
          fichaTecnicaFormController: widget.fichaTecnicaFormController,
          produtoListStore: widget.produtoListStore,
          unidadeListStore: widget.unidadeListStore,
          adaptiveModalNotifier: widget.adaptiveModalNotifier,
        );
      },
    ).then((value) => widget.adaptiveModalNotifier.value = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = translation;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Container(
      decoration: BoxDecoration(
        color: colorTheme?.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorTheme?.border ?? Colors.transparent,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 20, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        l10n.fields.material,
                        style: themeData.textTheme.labelLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorTheme?.label,
                        ),
                      ),
                      Text(
                        widget.material.produto == ProdutoEntity.empty() ? '' : widget.material.produto.nome,
                        style: themeData.textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: colorTheme?.icons,
                  ),
                  onSelected: (value) {
                    if (value == 1) {
                      widget.fichaTecnicaFormController.material = widget.material;
                      showModalCriarEditarMaterial();
                    } else {
                      Asuka.showDialog(
                        barrierColor: Colors.black38,
                        builder: (context) {
                          return ConfirmationModalWidget(
                            title: l10n.titles.excluirEntidade(l10n.fields.material),
                            messages: l10n.messages.excluirAEntidade(l10n.fields.material),
                            titleCancel: l10n.fields.excluir,
                            titleSuccess: l10n.fields.cancelar,
                            onCancel: () => widget.fichaTecnicaFormController.removerMaterial(widget.material.codigo),
                          );
                        },
                      );
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text(l10n.fields.editar),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Text(l10n.fields.excluir),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.fields.quantidade,
                      style: themeData.textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorTheme?.label,
                      ),
                    ),
                    Text(
                      widget.material.quantidade.toText,
                      style: themeData.textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.fields.tipoDeUnidade,
                      style: themeData.textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorTheme?.label,
                      ),
                    ),
                    Text(
                      widget.material.unidade == UnidadeEntity.empty()
                          ? ""
                          : "${widget.material.unidade.codigo} - ${widget.material.unidade.nome}",
                      style: themeData.textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
