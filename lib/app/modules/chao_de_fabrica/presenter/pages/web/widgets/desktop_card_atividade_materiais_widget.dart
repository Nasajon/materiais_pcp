// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/paginator_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_material_entity.dart';

class DesktopCardAtividadeMateriaisWidget extends StatefulWidget {
  final PaginatorVO<ChaoDeFabricaMaterialEntity> paginator;

  const DesktopCardAtividadeMateriaisWidget({
    Key? key,
    required this.paginator,
  }) : super(key: key);

  @override
  State<DesktopCardAtividadeMateriaisWidget> createState() => _DesktopCardAtividadeMateriaisWidgetState();
}

class _DesktopCardAtividadeMateriaisWidgetState extends State<DesktopCardAtividadeMateriaisWidget> {
  PaginatorVO<ChaoDeFabricaMaterialEntity> get paginator => widget.paginator;

  int page = 1;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<NhidsColorTheme>();

    final materiais = paginator.getItemsByPage(page);

    return Container(
      width: 472.responsive,
      height: 324.responsive,
      padding: EdgeInsets.all(20.responsive),
      decoration: BoxDecoration(
        border: Border.all(color: colorTheme?.border ?? Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translation.fields.materiais,
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          paginator.items.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(translation.messages.mensagemNaoHaMateriaisParaEstaAtividade),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    itemCount: materiais.length,
                    separatorBuilder: (_, __) => Divider(color: colorTheme?.border, height: 0),
                    itemBuilder: (_, index) {
                      final material = materiais[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.responsive),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NhidsTwoLineText(
                              title: translation.fields.materiais,
                              subtitle: material.produto.nome,
                              type: NhidsTextType.type2,
                            ),
                            SizedBox(width: 22.responsive),
                            NhidsTwoLineText(
                              title: translation.fields.quantidade,
                              subtitle:
                                  '${material.quantidade.formatDoubleToString(decimalDigits: material.unidade.decimal)} ${material.unidade.nome.toLowerCase()}',
                              type: NhidsTextType.type2,
                            ),
                            SizedBox(width: 22.responsive),
                            NhidsTwoLineText(
                              title: translation.fields.utilizado,
                              subtitle:
                                  '${material.quantidadeUtilizada.formatDoubleToString(decimalDigits: material.unidade.decimal)} ${material.unidade.nome.toLowerCase()}',
                              type: NhidsTextType.type2,
                            ),
                            SizedBox(width: 22.responsive),
                            NhidsTwoLineText(
                              title: translation.fields.perda,
                              subtitle:
                                  '${material.quantidadePerda.formatDoubleToString(decimalDigits: material.unidade.decimal)} ${material.unidade.nome.toLowerCase()}',
                              type: NhidsTextType.type2,
                            ),
                            SizedBox(width: 22.responsive),
                          ],
                        ),
                      );
                    },
                  ),
                ),
          if (paginator.totalPageCount > 1)
            NhidsPagination(
              pageTotal: paginator.totalPageCount,
              initialValue: page,
              onChanged: (value) => setState(() => page = value),
            ),
        ],
      ),
    );
  }
}
