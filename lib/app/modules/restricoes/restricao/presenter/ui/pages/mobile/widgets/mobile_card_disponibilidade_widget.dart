import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/disponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';

class MobileCardDisponibilidadeWidget extends StatelessWidget {
  final RestricaoFormController restricaoFormController;
  final DisponibilidadeEntity disponibilidade;

  const MobileCardDisponibilidadeWidget({
    Key? key,
    required this.restricaoFormController,
    required this.disponibilidade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    var diasDaSemana = '';

    for (var i = 0; i < disponibilidade.diasDaSemana.length; i++) {
      if (i < disponibilidade.diasDaSemana.length - 1) {
        diasDaSemana += '${disponibilidade.diasDaSemana[i].name} - ';
      } else {
        diasDaSemana += disponibilidade.diasDaSemana[i].name;
      }
    }

    return Container(
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
                      restricaoFormController.disponibilidade = disponibilidade;

                      Modular.to.pushNamed('/pcp/restricoes/disponibilidade');
                    } else {
                      restricaoFormController.removerDisponibilidade(disponibilidade.codigo);
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
                      '${disponibilidade.periodoInicial.dateFormat()} à ${disponibilidade.periodoFinal.dateFormat()}',
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
                      l10n.fields.diasDaSemana,
                      style: themeData.textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorTheme?.label,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        diasDaSemana,
                        style: themeData.textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          '${disponibilidade.horarioInicial.timeFormat(format: 'h') ?? ''} - ${disponibilidade.horarioFinal.timeFormat(format: 'h') ?? ''}',
                          style: themeData.textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.fields.intervalo,
                          style: themeData.textTheme.labelLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: colorTheme?.label,
                          ),
                        ),
                        Text(
                          '${disponibilidade.intervaloInicial.timeFormat(format: 'h') ?? ''} - ${disponibilidade.intervaloFinal.timeFormat(format: 'h') ?? ''}',
                          style: themeData.textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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
