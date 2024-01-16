// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_object_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_evento_aggregate.dart';

class DesktopLinhaSequenciamentoEventoWidget extends StatelessWidget {
  final List<SequenciamentoObjectAggregate> sequenciamentosObject;
  final Map<String, dynamic> eventoMap;

  const DesktopLinhaSequenciamentoEventoWidget({
    Key? key,
    required this.sequenciamentosObject,
    required this.eventoMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    final tableRowWidget = <TableRow>[];

    final listEventoMap = <Map<String, dynamic>>[];

    for (var i = 0; i < sequenciamentosObject.length; i++) {
      final sequenciamentoObject = sequenciamentosObject[i];

      final eventos = sequenciamentoObject.eventos.where((evento) => evento.operacaoRoteiro.operacaoId == eventoMap['id']).toList();

      for (var evento in eventos) {
        listEventoMap.add({
          'eventObject': sequenciamentoObject.eventObject,
          'evento': evento,
        });
      }
    }

    for (var i = 0; i < listEventoMap.length; i++) {
      final eventoMap = listEventoMap[i];
      tableRowWidget.add(
        TableRow(
          decoration: BoxDecoration(
            border: i < listEventoMap.length - 1
                ? Border(
                    bottom: BorderSide(
                      color: colorTheme?.border ?? Colors.transparent,
                    ),
                  )
                : null,
          ),
          children: [
            _LineTextWidget(
              title: eventoMap['eventObject'].nome,
              isItemFirst: i == 0,
              isItemLast: i == listEventoMap.length - 1,
            ),
            _LineTextWidget(
              title: (eventoMap['evento'] as SequenciamentoEventoAggregate).inicioPlanejado.dateFormat(format: 'dd/MM/yyyy HH:mm') ?? '',
              isItemFirst: i == 0,
              isItemLast: i == listEventoMap.length - 1,
            ),
            _LineTextWidget(
              title: (eventoMap['evento'] as SequenciamentoEventoAggregate).fimPlanejado.dateFormat(format: 'dd/MM/yyyy HH:mm') ?? '',
              isItemFirst: i == 0,
              isItemLast: i == listEventoMap.length - 1,
            ),
            _LineTextWidget(
              title: (eventoMap['evento'] as SequenciamentoEventoAggregate).ordemDeProducao.quantidade.formatDoubleToString(),
              isItemFirst: i == 0,
              isItemLast: i == listEventoMap.length - 1,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Table(
          children: [
            TableRow(
              children: [
                _LineTextWidget(
                  title: translation.fields.recurso,
                  isTitleTable: true,
                ),
                _LineTextWidget(
                  title: translation.fields.inicioPlanejado,
                  isTitleTable: true,
                ),
                _LineTextWidget(
                  title: translation.fields.fimPlanejado,
                  isTitleTable: true,
                ),
                _LineTextWidget(
                  title: translation.fields.quantidade,
                  isTitleTable: true,
                ),
              ],
            ),
            ...tableRowWidget
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _LineTextWidget extends StatelessWidget {
  final String title;
  final bool isTitleTable;
  final bool isItemFirst;
  final bool isItemLast;

  const _LineTextWidget({
    Key? key,
    required this.title,
    this.isTitleTable = false,
    this.isItemFirst = false,
    this.isItemLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        top: !isTitleTable
            ? isItemFirst
                ? 8
                : 16
            : 0,
        bottom: !isTitleTable && !isItemLast ? 16 : 0,
        left: 10,
        right: 10,
      ),
      child: Text(
        title,
        style: isTitleTable
            ? themeData.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              )
            : themeData.textTheme.bodyMedium,
      ),
    );
  }
}
