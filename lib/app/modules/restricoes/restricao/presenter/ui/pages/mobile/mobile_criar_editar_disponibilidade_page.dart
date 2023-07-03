import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/week_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';

class MobileCriarEditarDisponibilidade extends StatelessWidget {
  final RestricaoFormController restricaoFormController;

  MobileCriarEditarDisponibilidade({
    Key? key,
    required this.restricaoFormController,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      restricaoFormController.disponibilidade != null && restricaoFormController.disponibilidade?.codigo == 0
          ? l10n.titles.adicionarDisponibilidade
          : l10n.titles.editarDisponibilidade,
      controller: CustomScaffoldController(),
      alignment: Alignment.centerLeft,
      onIconTap: () {
        restricaoFormController.disponibilidade = null;

        Modular.to.pop();
      },
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              DateRangeTextFormFieldWidget(
                label: l10n.fields.periodo,
                initDateStart: restricaoFormController.disponibilidade?.periodoInicial.getDate(),
                initDateEnd: restricaoFormController.disponibilidade?.periodoFinal.getDate(),
                isRequiredField: true,
                initialEntryMode: DatePickerEntryMode.calendar,
                validator: (_) =>
                    restricaoFormController.disponibilidade?.periodoInicial.errorMessage ??
                    restricaoFormController.disponibilidade?.periodoFinal.errorMessage,
                dateTimeRange: (value) {
                  restricaoFormController.disponibilidade = restricaoFormController.disponibilidade?.copyWith(
                    periodoInicial: DateVO.date(value!.start),
                    periodoFinal: DateVO.date(value.end),
                  );
                },
              ),
              const SizedBox(height: 16),
              WeekToggleButtonsWidget(
                initialValue: restricaoFormController.disponibilidade?.copyWith().diasDaSemana.map((e) => e.code).toList(),
                onSelectedDaysOfWeek: (days) {
                  restricaoFormController.disponibilidade = restricaoFormController.disponibilidade?.copyWith(
                    diasDaSemana: days.map((e) => WeekEnum.selectDayOfWeek(e)).toList(),
                  );
                },
              ),
              const SizedBox(height: 16),
              TimeTextFormFieldWidget(
                  label: l10n.fields.horarioInicial,
                  initTime: restricaoFormController.disponibilidade?.horarioInicial.getTime(),
                  validator: (_) => restricaoFormController.disponibilidade?.horarioInicial.errorMessage,
                  onChanged: (value) {
                    if (value != null) {
                      restricaoFormController.disponibilidade =
                          restricaoFormController.disponibilidade?.copyWith(horarioInicial: TimeVO.time(value));
                    }
                  }),
              const SizedBox(height: 16),
              TimeTextFormFieldWidget(
                  label: l10n.fields.horarioFinal,
                  initTime: restricaoFormController.disponibilidade?.horarioFinal.getTime(),
                  validator: (_) => restricaoFormController.disponibilidade?.horarioFinal.errorMessage,
                  onChanged: (value) {
                    if (value != null) {
                      restricaoFormController.disponibilidade =
                          restricaoFormController.disponibilidade?.copyWith(horarioFinal: TimeVO.time(value));
                    }
                  }),
              CustomCheckBoxWithText(
                text: l10n.fields.diaInteiro,
                isChecked: restricaoFormController.disponibilidade?.diaInteiro ?? false,
                onChanged: (value) => restricaoFormController.disponibilidade = restricaoFormController.disponibilidade?.copyWith(
                  diaInteiro: value,
                ),
              ),
              const SizedBox(height: 16),
              TimeTextFormFieldWidget(
                  label: l10n.fields.intervaloInicial,
                  initTime: restricaoFormController.disponibilidade?.intervaloInicial.getTime(),
                  validator: (_) => restricaoFormController.disponibilidade?.intervaloInicial.errorMessage,
                  onChanged: (value) {
                    if (value != null) {
                      restricaoFormController.disponibilidade =
                          restricaoFormController.disponibilidade?.copyWith(intervaloInicial: TimeVO.time(value));
                    }
                  }),
              const SizedBox(height: 16),
              TimeTextFormFieldWidget(
                  label: l10n.fields.intervaloFinal,
                  initTime: restricaoFormController.disponibilidade?.intervaloFinal.getTime(),
                  validator: (_) => restricaoFormController.disponibilidade?.intervaloFinal.errorMessage,
                  onChanged: (value) {
                    if (value != null) {
                      restricaoFormController.disponibilidade =
                          restricaoFormController.disponibilidade?.copyWith(intervaloFinal: TimeVO.time(value));
                    }
                  }),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: restricaoFormController.disponibilidade != null && restricaoFormController.disponibilidade!.codigo > 0,
              child: CustomTextButton(
                title: l10n.fields.excluir,
                textColor: colorTheme?.danger,
                onPressed: () {
                  restricaoFormController.removerDisponibilidade(restricaoFormController.disponibilidade?.codigo ?? 0);

                  restricaoFormController.disponibilidade = null;

                  Modular.to.pop();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextButton(
                  title: l10n.fields.cancelar,
                  onPressed: () {
                    restricaoFormController.disponibilidade = null;

                    Modular.to.pop();
                  },
                ),
                const SizedBox(width: 16),
                CustomPrimaryButton(
                  title: l10n.fields.adicionar,
                  onPressed: () {
                    var disponibilidade = restricaoFormController.disponibilidade;
                    if (formKey.currentState!.validate() && disponibilidade != null) {
                      restricaoFormController.criarEditarDisponibilidade(disponibilidade);
                      Modular.to.pop();
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
