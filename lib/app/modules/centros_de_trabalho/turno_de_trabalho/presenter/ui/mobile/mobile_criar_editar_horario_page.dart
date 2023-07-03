import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/week_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/types/dias_da_semana_type.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';

class MobileCriarEditarHorario extends StatelessWidget {
  final TurnoTrabalhoFormController turnoTrabalhoFormController;

  MobileCriarEditarHorario({
    Key? key,
    required this.turnoTrabalhoFormController,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      turnoTrabalhoFormController.horario != null && turnoTrabalhoFormController.horario?.codigo == 0
          ? l10n.titles.adicionarHorario
          : l10n.titles.editarHorario,
      controller: CustomScaffoldController(),
      alignment: Alignment.centerLeft,
      onIconTap: () {
        turnoTrabalhoFormController.horario = null;

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
              Text(
                turnoTrabalhoFormController.horario != null && turnoTrabalhoFormController.horario?.codigo == 0
                    ? l10n.titles.adicionarHorario
                    : l10n.titles.editarHorario,
                style: themeData.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 28),
              WeekToggleButtonsWidget(
                initialValue: turnoTrabalhoFormController.horario?.copyWith().diasDaSemana.map((e) => e.code).toList(),
                onSelectedDaysOfWeek: (days) {
                  turnoTrabalhoFormController.horario = turnoTrabalhoFormController.horario?.copyWith(
                    diasDaSemana: days.map((e) => DiasDaSemanaType.selectDayOfWeek(e)).toList(),
                  );
                },
              ),
              const SizedBox(height: 16),
              TimeTextFormFieldWidget(
                label: l10n.fields.horarioInicial,
                initTime: turnoTrabalhoFormController.horario?.horarioInicial.getTime(),
                validator: (_) => turnoTrabalhoFormController.horario?.horarioInicial.errorMessage,
                onChanged: (value) {
                  if (value != null) {
                    turnoTrabalhoFormController.horario = turnoTrabalhoFormController.horario?.copyWith(horarioInicial: TimeVO.time(value));
                  }
                },
              ),
              const SizedBox(height: 16),
              TimeTextFormFieldWidget(
                label: l10n.fields.horarioFinal,
                initTime: turnoTrabalhoFormController.horario?.horarioFinal.getTime(),
                validator: (_) => turnoTrabalhoFormController.horario?.horarioFinal.errorMessage,
                onChanged: (value) {
                  if (value != null) {
                    turnoTrabalhoFormController.horario = turnoTrabalhoFormController.horario?.copyWith(horarioFinal: TimeVO.time(value));
                  }
                },
              ),
              const SizedBox(height: 16),
              TimeTextFormFieldWidget(
                label: l10n.fields.intervalo,
                initTime: turnoTrabalhoFormController.horario?.intervalo.getTime(),
                validator: (_) => turnoTrabalhoFormController.horario?.intervalo.errorMessage,
                onChanged: (value) {
                  if (value != null) {
                    turnoTrabalhoFormController.horario = turnoTrabalhoFormController.horario?.copyWith(intervalo: TimeVO.time(value));
                  }
                },
              ),
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
              visible: turnoTrabalhoFormController.horario != null && turnoTrabalhoFormController.horario!.codigo > 0,
              child: CustomTextButton(
                title: l10n.fields.excluir,
                textColor: colorTheme?.danger,
                onPressed: () {
                  turnoTrabalhoFormController.removerHorario(turnoTrabalhoFormController.horario?.codigo ?? 0);

                  turnoTrabalhoFormController.horario = null;

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
                    turnoTrabalhoFormController.horario = null;

                    Modular.to.pop();
                  },
                ),
                const SizedBox(width: 16),
                CustomPrimaryButton(
                  title: l10n.fields.adicionar,
                  onPressed: () {
                    var horario = turnoTrabalhoFormController.horario;
                    if (formKey.currentState!.validate() && horario != null) {
                      turnoTrabalhoFormController.criarEditarHorario(horario);
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
