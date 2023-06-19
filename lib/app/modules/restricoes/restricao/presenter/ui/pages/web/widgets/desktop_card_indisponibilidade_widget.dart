// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/indisponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';

class DesktopCardIndisponibilidadeWidget extends StatelessWidget {
  final RestricaoFormController restricaoFormController;
  final IndisponibilidadeEntity indisponibilidade;

  const DesktopCardIndisponibilidadeWidget({
    Key? key,
    required this.restricaoFormController,
    required this.indisponibilidade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return Container(
      constraints: const BoxConstraints(maxWidth: 276),
      decoration: BoxDecoration(
        color: colorTheme?.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorTheme?.border ?? Colors.transparent,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: colorTheme?.icons,
                  ),
                  onSelected: (value) {
                    if (value == 1) {
                      restricaoFormController.indisponibilidade = indisponibilidade;
                    } else {
                      restricaoFormController.removerIndisponibilidade(indisponibilidade.codigo);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text(l10n.fields.editar),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Text(l10n.fields.excluir),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.fields.periodo,
                      style: themeData.textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorTheme?.label,
                      ),
                    ),
                    Text(
                      '${indisponibilidade.periodoInicial.dateFormat()} à ${indisponibilidade.periodoFinal.dateFormat()}',
                      style: themeData.textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.fields.motivo,
                      style: themeData.textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorTheme?.label,
                      ),
                    ),
                    Text(
                      indisponibilidade.motivo.value,
                      style: themeData.textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.fields.horario,
                      style: themeData.textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorTheme?.label,
                      ),
                    ),
                    Text(
                      '${indisponibilidade.horarioInicial.timeFormat(format: 'h') ?? ''} - ${indisponibilidade.horarioFinal.timeFormat(format: 'h') ?? ''}',
                      style: themeData.textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
