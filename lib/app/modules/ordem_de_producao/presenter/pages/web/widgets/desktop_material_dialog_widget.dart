import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/material_entity.dart';

class DesktopMaterialDialogWidget extends StatelessWidget {
  final List<MaterialEntity> materiais;

  const DesktopMaterialDialogWidget({
    Key? key,
    required this.materiais,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Container(
      width: 456,
      constraints: const BoxConstraints(maxHeight: 580),
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 14,
        left: 14,
        right: 14,
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
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Flexible(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  ...materiais
                      .map(
                        (material) => Container(
                          width: 206,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: colorTheme?.background,
                            border: Border.all(
                              color: colorTheme?.border ?? Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                material.produto.nome,
                                style: themeData.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                translation.fields.quantidade,
                                style: themeData.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${material.quantidade.formatDoubleToString(decimalDigits: material.unidade.decimal)} ${material.unidade.nome}',
                                style: themeData.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomPrimaryButton(
                title: translation.fields.voltar,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
