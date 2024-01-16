// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart' hide showModalBottomSheet;
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_produto_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/unidades_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/mobile/mobile_criar_editar_material_page.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/mobile/widgets/mobile_card_material_widget.dart';

class MobileMaterialFormWidget extends StatefulWidget {
  final FichaTecnicaFormController fichaTecnicaFormController;
  final ValueNotifier<bool> adaptiveModalNotifier;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;

  const MobileMaterialFormWidget({
    Key? key,
    required this.fichaTecnicaFormController,
    required this.adaptiveModalNotifier,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  State<MobileMaterialFormWidget> createState() => _MobileMaterialFormWidgetState();
}

class _MobileMaterialFormWidgetState extends State<MobileMaterialFormWidget> {
  final formKey = GlobalKey<FormState>;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void showModalCriarEditarFichaTecnicaMaterial() {
    widget.adaptiveModalNotifier.value = true;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MobileCriarEditarMaterialPage(
          fichaTecnicaFormController: widget.fichaTecnicaFormController,
          adaptiveModalNotifier: widget.adaptiveModalNotifier,
          produtoListStore: widget.produtoListStore,
          unidadeListStore: widget.unidadeListStore,
        );
      },
    ).then((value) => widget.adaptiveModalNotifier.value = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = translation;
    final themeData = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: SizedBox(
            width: constraints.maxWidth,
            child: RxBuilder(
              builder: (_) {
                Widget addButton = CustomOutlinedButton(
                  title: l10n.fields.adicionarMaterial,
                  onPressed: () async {
                    widget.fichaTecnicaFormController.material = FichaTecnicaMaterialAggregate.empty();

                    showModalCriarEditarFichaTecnicaMaterial();
                  },
                );

                if (widget.fichaTecnicaFormController.fichaTecnica.materiais.isEmpty) {
                  return Column(
                    children: [
                      const SizedBox(height: 36),
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
                  );
                }

                int index = 0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ...widget.fichaTecnicaFormController.fichaTecnica.materiais.map((material) {
                          index++;

                          return MobileCardMaterialWidget(
                            key: ValueKey(index),
                            fichaTecnicaFormController: widget.fichaTecnicaFormController,
                            produtoListStore: widget.produtoListStore,
                            unidadeListStore: widget.unidadeListStore,
                            adaptiveModalNotifier: widget.adaptiveModalNotifier,
                            material: material,
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Visibility(
                        child: addButton,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
