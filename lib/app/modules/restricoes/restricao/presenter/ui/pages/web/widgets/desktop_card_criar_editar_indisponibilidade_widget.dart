import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/week_toggle_buttons_widget.dart';

class DesktopCardCriarEditarIndisponibilidadeWidget extends StatelessWidget {
  final RestricaoFormController restricaoFormController;
  final GlobalKey<FormState> formKey;

  const DesktopCardCriarEditarIndisponibilidadeWidget({
    Key? key,
    required this.restricaoFormController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    final indisponibilidade = restricaoFormController.indisponibilidade;

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
              indisponibilidade != null && indisponibilidade.codigo == 0
                  ? l10n.titles.adicionarIndisponibilidade
                  : l10n.titles.editarIndisponibilidade,
              style: themeData.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 28),
            DateRangeTextFormFieldWidget(
              label: l10n.fields.periodo,
              isRequiredField: true,
              initDateStart: indisponibilidade?.periodoInicial.getDate(),
              initDateEnd: indisponibilidade?.periodoFinal.getDate(),
              validator: (_) => indisponibilidade?.periodoInicial.errorMessage ?? indisponibilidade?.periodoFinal.errorMessage,
              dateTimeRange: (value) {
                restricaoFormController.indisponibilidade = indisponibilidade?.copyWith(
                  periodoInicial: DateVO.date(value!.start),
                  periodoFinal: DateVO.date(value.end),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              label: l10n.fields.motivo,
              initialValue: indisponibilidade?.motivo.value,
              validator: (_) => indisponibilidade?.motivo.errorMessage,
              onChanged: (value) {
                restricaoFormController.indisponibilidade = indisponibilidade?.copyWith(
                  motivo: TextVO(value),
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
                      initTime: indisponibilidade?.horarioInicial.getTime(),
                      validator: (_) => indisponibilidade?.horarioInicial.errorMessage,
                      onChanged: (value) {
                        if (value != null) {
                          restricaoFormController.indisponibilidade = indisponibilidade?.copyWith(horarioInicial: TimeVO.time(value));
                        }
                      }),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TimeTextFormFieldWidget(
                      label: l10n.fields.horarioFinal,
                      initTime: indisponibilidade?.horarioFinal.getTime(),
                      validator: (_) => indisponibilidade?.horarioFinal.errorMessage,
                      onChanged: (value) {
                        if (value != null) {
                          restricaoFormController.indisponibilidade = indisponibilidade?.copyWith(horarioFinal: TimeVO.time(value));
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
                  visible: indisponibilidade != null && indisponibilidade.codigo > 0,
                  child: CustomTextButton(
                    title: l10n.fields.excluir,
                    onPressed: () {
                      restricaoFormController.removerIndisponibilidade(indisponibilidade?.codigo ?? 0);

                      restricaoFormController.indisponibilidade = null;
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
                      onPressed: () => restricaoFormController.indisponibilidade = null,
                    ),
                    const SizedBox(width: 16),
                    CustomOutlinedButton(
                      title: l10n.fields.salvar,
                      onPressed: () {
                        var indisponibilidade = restricaoFormController.indisponibilidade;
                        if (formKey.currentState!.validate() && indisponibilidade != null) {
                          restricaoFormController.criarEditarIndisponibilidade(indisponibilidade);
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
