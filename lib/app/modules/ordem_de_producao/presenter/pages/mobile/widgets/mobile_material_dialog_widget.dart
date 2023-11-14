import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/material_entity.dart';

class MobileMaterialDialogWidget extends StatelessWidget {
  final List<MaterialEntity> materiais;

  const MobileMaterialDialogWidget({
    Key? key,
    required this.materiais,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      translation.titles.materiais,
      controller: CustomScaffoldController(),
      alignment: Alignment.centerLeft,
      closeIcon: Icon(FontAwesomeIcons.xmark, color: colorTheme?.text),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: materiais.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final material = materiais[index];
          return Container(
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
          );
        },
      ),
    );
  }
}
