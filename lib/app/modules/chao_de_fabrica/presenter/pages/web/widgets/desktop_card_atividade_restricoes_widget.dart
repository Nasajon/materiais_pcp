// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/paginator_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_restricao_entity.dart';

class DesktopCardAtividadeRestricoesWidget extends StatefulWidget {
  final PaginatorVO<ChaoDeFabricaRestricaoEntity> paginator;

  const DesktopCardAtividadeRestricoesWidget({
    Key? key,
    required this.paginator,
  }) : super(key: key);

  @override
  State<DesktopCardAtividadeRestricoesWidget> createState() => _DesktopCardAtividadeRestricoesWidgetState();
}

class _DesktopCardAtividadeRestricoesWidgetState extends State<DesktopCardAtividadeRestricoesWidget> {
  PaginatorVO<ChaoDeFabricaRestricaoEntity> get paginator => widget.paginator;

  int page = 1;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<NhidsColorTheme>();

    final restricoes = paginator.getItemsByPage(page);

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
            translation.fields.restricoes,
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          paginator.items.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(translation.messages.mensagemNaoHaRestricoesParaEstaAtividade),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    itemCount: restricoes.length,
                    separatorBuilder: (_, __) => Divider(color: colorTheme?.border, height: 0),
                    itemBuilder: (_, index) {
                      final restricao = restricoes[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.responsive),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NhidsTwoLineText(
                              title: translation.fields.restricao,
                              subtitle: restricao.nome,
                              type: NhidsTextType.type2,
                            ),
                            SizedBox(width: 22.responsive),
                            NhidsTwoLineText(
                              title: translation.fields.capacidade,
                              subtitle:
                                  '${restricao.capacidade.formatDoubleToString(decimalDigits: restricao.unidade.decimal)} ${restricao.unidade.codigo.toLowerCase()}',
                              type: NhidsTextType.type2,
                            ),
                            SizedBox(width: 22.responsive),
                            NhidsTwoLineText(
                              title: translation.fields.utilizar,
                              subtitle:
                                  '${restricao.usar.formatDoubleToString(decimalDigits: restricao.unidade.decimal)} ${restricao.unidade.codigo.toLowerCase()}',
                              type: NhidsTextType.type2,
                            ),
                            SizedBox(width: 22.responsive),
                            NhidsTwoLineText(
                              title: translation.fields.quando,
                              subtitle:
                                  '${TimeVO.calculateDateDifference(restricao.inicioPlanejado.getDate() ?? DateTime.now(), restricao.fimPlanejado.getDate() ?? DateTime.now())} ${restricao.medicaoTempo.name}',
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
