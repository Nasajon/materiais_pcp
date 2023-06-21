import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/week_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/week_toggle_buttons_widget.dart';

class DesktopCardCriarEditarDisponibilidadeWidget extends StatelessWidget {
  final RestricaoFormController restricaoFormController;
  final GlobalKey<FormState> formKey;

  const DesktopCardCriarEditarDisponibilidadeWidget({
    Key? key,
    required this.restricaoFormController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    final disponibilidade = restricaoFormController.disponibilidade;

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
              disponibilidade != null && disponibilidade.codigo == 0
                  ? l10n.titles.adicionarDisponibilidade
                  : l10n.titles.editarDisponibilidade,
              style: themeData.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 28),
            DateRangeTextFormFieldWidget(
              label: l10n.fields.periodo,
              isRequiredField: true,
              initDateStart: disponibilidade?.periodoInicial.getDate(),
              initDateEnd: disponibilidade?.periodoFinal.getDate(),
              validator: (_) => disponibilidade?.periodoInicial.errorMessage ?? disponibilidade?.periodoFinal.errorMessage,
              dateTimeRange: (value) {
                restricaoFormController.disponibilidade = disponibilidade?.copyWith(
                  periodoInicial: DateVO.date(value!.start),
                  periodoFinal: DateVO.date(value.end),
                );
              },
            ),
            const SizedBox(height: 16),
            WeekToggleButtonsWidget(
              initialValue: disponibilidade?.copyWith().diasDaSemana.map((e) => e.code).toList(),
              onSelectedDaysOfWeek: (days) {
                restricaoFormController.disponibilidade = disponibilidade?.copyWith(
                  diasDaSemana: days.map((e) => WeekEnum.selectDayOfWeek(e)).toList(),
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
                      initTime: disponibilidade?.horarioInicial.getTime(),
                      validator: (_) => disponibilidade?.horarioInicial.errorMessage,
                      onChanged: (value) {
                        if (value != null) {
                          restricaoFormController.disponibilidade = disponibilidade?.copyWith(horarioInicial: TimeVO.time(value));
                        }
                      }),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TimeTextFormFieldWidget(
                      label: l10n.fields.horarioFinal,
                      initTime: disponibilidade?.horarioFinal.getTime(),
                      validator: (_) => disponibilidade?.horarioFinal.errorMessage,
                      onChanged: (value) {
                        if (value != null) {
                          restricaoFormController.disponibilidade = disponibilidade?.copyWith(horarioFinal: TimeVO.time(value));
                        }
                      }),
                ),
              ],
            ),
            CustomCheckBoxWithText(
              text: l10n.fields.diaInteiro,
              isChecked: disponibilidade?.diaInteiro ?? false,
              onChanged: (value) => restricaoFormController.disponibilidade = disponibilidade?.copyWith(
                diaInteiro: value,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TimeTextFormFieldWidget(
                      label: l10n.fields.intervaloInicial,
                      initTime: disponibilidade?.intervaloInicial.getTime(),
                      validator: (_) => disponibilidade?.intervaloInicial.errorMessage,
                      onChanged: (value) {
                        if (value != null) {
                          restricaoFormController.disponibilidade = disponibilidade?.copyWith(intervaloInicial: TimeVO.time(value));
                        }
                      }),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TimeTextFormFieldWidget(
                      label: l10n.fields.intervaloFinal,
                      initTime: disponibilidade?.intervaloFinal.getTime(),
                      validator: (_) => disponibilidade?.intervaloFinal.errorMessage,
                      onChanged: (value) {
                        if (value != null) {
                          restricaoFormController.disponibilidade = disponibilidade?.copyWith(intervaloFinal: TimeVO.time(value));
                        }
                      }),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: disponibilidade != null && disponibilidade.codigo > 0,
                  child: CustomTextButton(
                    title: l10n.fields.excluir,
                    onPressed: () {
                      restricaoFormController.removerDisponibilidade(disponibilidade?.codigo ?? 0);

                      restricaoFormController.disponibilidade = null;
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
                      onPressed: () => restricaoFormController.disponibilidade = null,
                    ),
                    const SizedBox(width: 16),
                    CustomOutlinedButton(
                      title: l10n.fields.adicionar,
                      onPressed: () {
                        var disponibilidade = restricaoFormController.disponibilidade;
                        if (formKey.currentState!.validate() && disponibilidade != null) {
                          restricaoFormController.criarEditarDisponibilidade(disponibilidade);
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
