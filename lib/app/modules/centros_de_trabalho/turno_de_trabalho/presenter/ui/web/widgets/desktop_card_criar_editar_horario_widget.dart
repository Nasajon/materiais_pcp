import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/week_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/types/dias_da_semana_type.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';

class DesktopCardCriarEditarHorarioWidget extends StatelessWidget {
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final GlobalKey<FormState> formKey;

  const DesktopCardCriarEditarHorarioWidget({
    Key? key,
    required this.turnoTrabalhoFormController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    final horario = turnoTrabalhoFormController.horario;

    return Container(
      width: 362,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorTheme?.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorTheme?.border ?? Colors.transparent,
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              horario != null && horario.codigo == 0 ? l10n.titles.adicionarHorario : l10n.titles.editarHorario,
              style: themeData.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 28),
            WeekToggleButtonsWidget(
              initialValue: horario?.copyWith().diasDaSemana.map((e) => e.code).toList(),
              onSelectedDaysOfWeek: (days) {
                turnoTrabalhoFormController.horario = horario?.copyWith(
                  diasDaSemana: days.map((e) => DiasDaSemanaType.selectDayOfWeek(e)).toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TimeTextFormFieldWidget(
                      label: l10n.fields.horarioInicial,
                      initTime: horario?.horarioInicial.getTime(),
                      validator: (_) => horario?.horarioInicial.errorMessage,
                      onChanged: (value) {
                        if (value != null) {
                          turnoTrabalhoFormController.horario = horario?.copyWith(horarioInicial: TimeVO.time(value));
                        }
                      }),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TimeTextFormFieldWidget(
                      label: l10n.fields.horarioFinal,
                      initTime: horario?.horarioFinal.getTime(),
                      validator: (_) => horario?.horarioFinal.errorMessage,
                      onChanged: (value) {
                        if (value != null) {
                          turnoTrabalhoFormController.horario = horario?.copyWith(horarioFinal: TimeVO.time(value));
                        }
                      }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TimeTextFormFieldWidget(
              label: l10n.fields.intervalo,
              initTime: horario?.intervalo.getTime(),
              validator: (_) => horario?.intervalo.errorMessage,
              onChanged: (value) {
                if (value != null) {
                  turnoTrabalhoFormController.horario = horario?.copyWith(intervalo: TimeVO.time(value));
                }
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: horario != null && horario.codigo > 0,
                  child: CustomTextButton(
                    title: l10n.fields.excluir,
                    onPressed: () {
                      turnoTrabalhoFormController.removerHorario(horario?.codigo ?? 0);

                      turnoTrabalhoFormController.horario = null;
                    },
                    textColor: colorTheme?.danger,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextButton(
                      title: l10n.fields.cancelar,
                      onPressed: () => turnoTrabalhoFormController.horario = null,
                    ),
                    const SizedBox(width: 16),
                    CustomOutlinedButton(
                      title: l10n.fields.adicionar,
                      onPressed: () {
                        var horario = turnoTrabalhoFormController.horario;
                        if (formKey.currentState!.validate() && horario != null) {
                          turnoTrabalhoFormController.criarEditarHorario(horario);
                        }
                      },
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
