import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/entities/horario_entity.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';

class DesktopCardHorarioWidget extends StatelessWidget {
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final HorarioEntity horario;

  const DesktopCardHorarioWidget({
    Key? key,
    required this.turnoTrabalhoFormController,
    required this.horario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    var diasDaSemana = '';

    for (var i = 0; i < horario.diasDaSemana.length; i++) {
      if (i < horario.diasDaSemana.length - 1) {
        diasDaSemana += '${horario.diasDaSemana[i].name} - ';
      } else {
        diasDaSemana += horario.diasDaSemana[i].name;
      }
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 286),
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
            padding: const EdgeInsets.only(top: 8, left: 20, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        translation.fields.diasDaSemana,
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
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: colorTheme?.icons,
                  ),
                  onSelected: (value) {
                    if (value == 1) {
                      turnoTrabalhoFormController.horario = horario;
                    } else {
                      Asuka.showDialog(
                        barrierColor: Colors.black38,
                        builder: (context) {
                          return ConfirmationModalWidget(
                            title: translation.titles.excluirEntidade(translation.fields.horario),
                            messages: translation.messages.excluirAEntidade(translation.titles.turnosDeTrabalho),
                            titleCancel: translation.fields.excluir,
                            titleSuccess: translation.fields.cancelar,
                            onCancel: () => turnoTrabalhoFormController.removerHorario(horario.codigo),
                          );
                        },
                      );
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text(translation.fields.editar),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Text(translation.fields.excluir),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                      translation.fields.horario,
                      style: themeData.textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorTheme?.label,
                      ),
                    ),
                    Text(
                      '${horario.horarioInicial.timeFormat(format: 'h') ?? ''} - ${horario.horarioFinal.timeFormat(format: 'h') ?? ''}',
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
                      translation.fields.intervalo,
                      style: themeData.textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorTheme?.label,
                      ),
                    ),
                    Text(
                      horario.intervalo.timeFormat(format: 'h') ?? '',
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
