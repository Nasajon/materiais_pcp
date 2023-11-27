// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';

import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';

class DesktopCardOrdemProducaoWidget extends StatelessWidget {
  final OrdemDeProducaoAggregate ordemDeProducao;

  const DesktopCardOrdemProducaoWidget({
    Key? key,
    required this.ordemDeProducao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorTheme?.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(38, 0, 0, 0),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _LineTextWidget(title: translation.fields.ordemDeProducao, bodyText: ordemDeProducao.codigo.toText),
          const SizedBox(width: 24),
          _LineTextWidget(title: translation.fields.produto, bodyText: ordemDeProducao.produto.nome),
          const SizedBox(width: 24),
          _LineTextWidget(title: translation.fields.roteiroDeProducao, bodyText: ordemDeProducao.roteiro.nome),
          const SizedBox(width: 24),
          _LineTextWidget(title: translation.fields.previsaoDeEntrega, bodyText: ordemDeProducao.previsaoDeEntrega.dateFormat() ?? ''),
        ],
      ),
    );
  }
}

class _LineTextWidget extends StatelessWidget {
  final String title;
  final String bodyText;

  const _LineTextWidget({
    super.key,
    required this.title,
    required this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: themeData.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          bodyText,
          style: themeData.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
