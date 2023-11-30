// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_recurso_evento_aggregate.dart';

class DesktopLinhaSequenciamentoEventoWidget extends StatelessWidget {
  final List<SequenciamentoRecursoEventoAggregate> sequenciamentoRecursoEvento;

  const DesktopLinhaSequenciamentoEventoWidget({
    Key? key,
    required this.sequenciamentoRecursoEvento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    final tableRowWidget = <TableRow>[];

    for (var i = 0; i < sequenciamentoRecursoEvento.length; i++) {
      final evento = sequenciamentoRecursoEvento[i];
      tableRowWidget.add(
        TableRow(
          decoration: BoxDecoration(
            border: i < sequenciamentoRecursoEvento.length - 1
                ? Border(
                    bottom: BorderSide(
                      color: colorTheme?.border ?? Colors.transparent,
                    ),
                  )
                : null,
          ),
          children: [
            _LineTextWidget(
              title: evento.inicioPlanejado.dateFormat(format: 'dd/MM/yyyy HH:mm') ?? '',
              isSizeLength: i == sequenciamentoRecursoEvento.length - 1,
            ),
            _LineTextWidget(
              title: evento.inicioPlanejado.dateFormat(format: 'dd/MM/yyyy HH:mm') ?? '',
              isSizeLength: i == sequenciamentoRecursoEvento.length - 1,
            ),
            _LineTextWidget(
              title: evento.operacaoRoteiro.nome,
              isSizeLength: i == sequenciamentoRecursoEvento.length - 1,
            ),
            _LineTextWidget(
              title: evento.ordemDeProducao.codigo,
              isSizeLength: i == sequenciamentoRecursoEvento.length - 1,
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
                  title: translation.fields.inicioPlanejado,
                  isTitleTable: true,
                ),
                _LineTextWidget(
                  title: translation.fields.fimPlanejado,
                  isTitleTable: true,
                ),
                _LineTextWidget(
                  title: translation.fields.operacao,
                  isTitleTable: true,
                ),
                _LineTextWidget(
                  title: translation.fields.ordemDeProducao,
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
  final bool isSizeLength;

  const _LineTextWidget({
    Key? key,
    required this.title,
    this.isTitleTable = false,
    this.isSizeLength = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: !isTitleTable && !isSizeLength ? 16 : 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isTitleTable) const SizedBox(height: 8),
          Text(
            title,
            style: isTitleTable
                ? themeData.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  )
                : themeData.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
