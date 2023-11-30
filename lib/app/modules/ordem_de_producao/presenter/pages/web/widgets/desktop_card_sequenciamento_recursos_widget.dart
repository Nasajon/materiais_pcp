// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/widgets/desktop_linha_sequenciamento_evento_widget.dart';

class DesktopCardSequenciamentoRecursosWidget extends StatefulWidget {
  final List<SequenciamentoRecursoAggregate> sequenciamentosRecursos;

  const DesktopCardSequenciamentoRecursosWidget({
    Key? key,
    required this.sequenciamentosRecursos,
  }) : super(key: key);

  @override
  State<DesktopCardSequenciamentoRecursosWidget> createState() => _DesktopCardSequenciamentoRecursosWidgetState();
}

class _DesktopCardSequenciamentoRecursosWidgetState extends State<DesktopCardSequenciamentoRecursosWidget> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorTheme?.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorTheme?.border ?? Colors.grey,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                translation.fields.recursos,
                style: themeData.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ...widget.sequenciamentosRecursos.map((sequenciamentoRecurso) {
                return ExpansionTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  collapsedTextColor: colorTheme?.text,
                  textColor: colorTheme?.text,
                  iconColor: colorTheme?.text,
                  collapsedIconColor: colorTheme?.text,
                  backgroundColor: colorTheme?.background,
                  shape: Border.all(color: colorTheme?.background ?? Colors.transparent),
                  title: Text(
                    sequenciamentoRecurso.recurso.nome,
                  ),
                  children: [
                    Divider(color: colorTheme?.border, height: 1),
                    const SizedBox(height: 16),
                    DesktopLinhaSequenciamentoEventoWidget(sequenciamentoRecursoEvento: sequenciamentoRecurso.eventos),
                    Divider(color: colorTheme?.border, height: 1),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
