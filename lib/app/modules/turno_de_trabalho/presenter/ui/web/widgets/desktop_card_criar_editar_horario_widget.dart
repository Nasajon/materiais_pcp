import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/types/dias_da_semana_type.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';

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
              horario != null && horario.codigo == 0 ? translation.titles.adicionarHorario : translation.titles.editarHorario,
              style: themeData.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            WeekToggleButtonsWidget(
              initialValue: horario?.copyWith().diasDaSemana.map((e) => e.code).toList(),
              onSelectedDaysOfWeek: (days) {
                turnoTrabalhoFormController.horario = horario?.copyWith(
                  diasDaSemana: days.map((e) => DiasDaSemanaType.selectDayOfWeek(e)).toList(),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TimeTextFormFieldWidget(
                      label: translation.fields.horarioInicial,
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
                      label: translation.fields.horarioFinal,
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
              label: translation.fields.intervalo,
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
                    title: translation.fields.excluir,
                    onPressed: () {
                      Asuka.showDialog(
                        barrierColor: Colors.black38,
                        builder: (context) {
                          return ConfirmationModalWidget(
                            title: translation.titles.excluirEntidade(translation.fields.horario),
                            messages: translation.messages.excluirAEntidade(translation.titles.turnosDeTrabalho),
                            titleCancel: translation.fields.excluir,
                            titleSuccess: translation.fields.cancelar,
                            onCancel: () {
                              turnoTrabalhoFormController.removerHorario(horario?.codigo ?? 0);

                              turnoTrabalhoFormController.horario = null;
                            },
                          );
                        },
                      );
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
                      title: translation.fields.cancelar,
                      onPressed: () => turnoTrabalhoFormController.horario = null,
                    ),
                    const SizedBox(width: 16),
                    CustomOutlinedButton(
                      title: horario != null && horario.codigo > 0 ? translation.fields.salvar : translation.fields.adicionar,
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
