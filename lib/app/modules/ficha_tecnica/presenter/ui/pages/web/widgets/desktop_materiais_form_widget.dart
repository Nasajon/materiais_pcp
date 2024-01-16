import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_produto_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/unidades_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/web/widgets/desktop_card_criar_editar_material_widget.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/web/widgets/desktop_card_material_widget.dart';

class DesktopMateriaisFormWidget extends StatelessWidget {
  final FichaTecnicaFormController fichaTecnicaFormController;
  final GlobalKey<FormState> formKey;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;
  final bool isButtonAtTop;

  const DesktopMateriaisFormWidget({
    Key? key,
    required this.fichaTecnicaFormController,
    required this.formKey,
    this.isButtonAtTop = false,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = translation;
    final themeData = Theme.of(context);
    return RxBuilder(
      builder: (_) {
        Widget addButton = CustomOutlinedButton(
            title: l10n.fields.adicionarMaterial,
            onPressed: () async {
              fichaTecnicaFormController.material = FichaTecnicaMaterialAggregate.empty();
            });

        if (fichaTecnicaFormController.fichaTecnica.materiais.isEmpty && fichaTecnicaFormController.material == null) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 390),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    l10n.titles.adicioneUmMaterial,
                    style: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.messages.nenhumMaterialFoiAdicionado,
                    textAlign: TextAlign.center,
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  addButton,
                ],
              ),
            ),
          );
        }

        int index = 0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Visibility(
                visible: isButtonAtTop && fichaTecnicaFormController.material == null,
                child: addButton,
              ),
            ),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ...fichaTecnicaFormController.fichaTecnica.materiais.map((material) {
                  index++;
                  if (fichaTecnicaFormController.material?.codigo == index) {
                    return DesktopCardCriarEditarMaterialWidget(
                      key: ValueKey(index),
                      fichaTecnicaFormController: fichaTecnicaFormController,
                      produtoListStore: produtoListStore,
                      unidadeListStore: unidadeListStore,
                      formKey: formKey,
                    );
                  }

                  return DesktopCardMaterialWidget(
                    key: ValueKey(index),
                    fichaTecnicaFormController: fichaTecnicaFormController,
                    material: material,
                  );
                }).toList(),
                if (fichaTecnicaFormController.material?.codigo == 0) ...[
                  DesktopCardCriarEditarMaterialWidget(
                    key: const ValueKey(null),
                    fichaTecnicaFormController: fichaTecnicaFormController,
                    produtoListStore: produtoListStore,
                    unidadeListStore: unidadeListStore,
                    formKey: formKey,
                  ),
                ]
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Visibility(
                visible: !isButtonAtTop && fichaTecnicaFormController.material == null,
                child: addButton,
              ),
            )
          ],
        );
      },
    );
  }
}
