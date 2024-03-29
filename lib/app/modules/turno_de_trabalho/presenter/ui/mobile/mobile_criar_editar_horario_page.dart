import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/types/dias_da_semana_type.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';

class MobileCriarEditarHorario extends StatefulWidget {
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final ValueNotifier<bool> adaptiveModalNotifier;

  MobileCriarEditarHorario({
    Key? key,
    required this.turnoTrabalhoFormController,
    required this.adaptiveModalNotifier,
  }) : super(key: key);

  @override
  State<MobileCriarEditarHorario> createState() => _MobileCriarEditarHorarioState();
}

class _MobileCriarEditarHorarioState extends State<MobileCriarEditarHorario> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    widget.turnoTrabalhoFormController.horario = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    verificarHorarioRouter();
  }

  void verificarHorarioRouter() {
    if (!ScreenSizeUtil(context).isMobile && widget.adaptiveModalNotifier.value) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return CustomScaffold.titleString(
      key: _scaffoldKey,
      widget.turnoTrabalhoFormController.horario != null && widget.turnoTrabalhoFormController.horario?.codigo == 0
          ? translation.titles.adicionarHorario
          : translation.titles.editarHorario,
      controller: CustomScaffoldController(),
      alignment: Alignment.centerLeft,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.turnoTrabalhoFormController.horario != null && widget.turnoTrabalhoFormController.horario?.codigo == 0
                    ? translation.titles.adicionarHorario
                    : translation.titles.editarHorario,
                style: themeData.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              WeekToggleButtonsWidget(
                initialValue: widget.turnoTrabalhoFormController.horario?.copyWith().diasDaSemana.map((e) => e.code).toList(),
                onSelectedDaysOfWeek: (days) {
                  widget.turnoTrabalhoFormController.horario = widget.turnoTrabalhoFormController.horario?.copyWith(
                    diasDaSemana: days.map((e) => DiasDaSemanaType.selectDayOfWeek(e)).toList(),
                  );
                },
              ),
              const SizedBox(height: 16),
              TimeTextFormFieldWidget(
                label: translation.fields.horarioInicial,
                initTime: widget.turnoTrabalhoFormController.horario?.horarioInicial.getTime(),
                validator: (_) => widget.turnoTrabalhoFormController.horario?.horarioInicial.errorMessage,
                onChanged: (value) {
                  if (value != null) {
                    widget.turnoTrabalhoFormController.horario =
                        widget.turnoTrabalhoFormController.horario?.copyWith(horarioInicial: TimeVO.time(value));
                  }
                },
              ),
              const SizedBox(height: 20),
              TimeTextFormFieldWidget(
                label: translation.fields.horarioFinal,
                initTime: widget.turnoTrabalhoFormController.horario?.horarioFinal.getTime(),
                validator: (_) => widget.turnoTrabalhoFormController.horario?.horarioFinal.errorMessage,
                onChanged: (value) {
                  if (value != null) {
                    widget.turnoTrabalhoFormController.horario =
                        widget.turnoTrabalhoFormController.horario?.copyWith(horarioFinal: TimeVO.time(value));
                  }
                },
              ),
              const SizedBox(height: 16),
              TimeTextFormFieldWidget(
                label: translation.fields.intervalo,
                initTime: widget.turnoTrabalhoFormController.horario?.intervalo.getTime(),
                validator: (_) => widget.turnoTrabalhoFormController.horario?.intervalo.errorMessage,
                onChanged: (value) {
                  if (value != null) {
                    widget.turnoTrabalhoFormController.horario =
                        widget.turnoTrabalhoFormController.horario?.copyWith(intervalo: TimeVO.time(value));
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
              visible: widget.turnoTrabalhoFormController.horario != null && widget.turnoTrabalhoFormController.horario!.codigo > 0,
              child: CustomTextButton(
                title: translation.fields.excluir,
                textColor: colorTheme?.danger,
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
                          widget.turnoTrabalhoFormController.removerHorario(widget.turnoTrabalhoFormController.horario?.codigo ?? 0);

                          widget.turnoTrabalhoFormController.horario = null;

                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextButton(
                  title: translation.fields.cancelar,
                  onPressed: () {
                    widget.turnoTrabalhoFormController.horario = null;

                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 16),
                CustomPrimaryButton(
                  title: widget.turnoTrabalhoFormController.horario != null && widget.turnoTrabalhoFormController.horario!.codigo > 0
                      ? translation.fields.salvar
                      : translation.fields.adicionar,
                  onPressed: () {
                    var horario = widget.turnoTrabalhoFormController.horario;
                    if (formKey.currentState!.validate() && horario != null) {
                      widget.turnoTrabalhoFormController.criarEditarHorario(horario);
                      Navigator.of(context).pop();
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
