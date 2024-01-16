// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/controllers/restricao_form_controller.dart';

class MobileCriarEditarIndisponibilidadePage extends StatefulWidget {
  final RestricaoFormController restricaoFormController;
  final ValueNotifier<bool> adaptiveModalNotifier;

  const MobileCriarEditarIndisponibilidadePage({
    Key? key,
    required this.restricaoFormController,
    required this.adaptiveModalNotifier,
  }) : super(key: key);

  @override
  State<MobileCriarEditarIndisponibilidadePage> createState() => _MobileCriarEditarIndisponibilidadePageState();
}

class _MobileCriarEditarIndisponibilidadePageState extends State<MobileCriarEditarIndisponibilidadePage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
      widget.restricaoFormController.indisponibilidade != null && widget.restricaoFormController.indisponibilidade?.codigo == 0
          ? translation.titles.adicionarIndisponibilidade
          : translation.titles.editarIndisponibilidade,
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
              const SizedBox(height: 32),
              DateRangeTextFormFieldWidget(
                label: translation.fields.periodo,
                initDateStart: widget.restricaoFormController.indisponibilidade?.periodoInicial.getDate(),
                initDateEnd: widget.restricaoFormController.indisponibilidade?.periodoFinal.getDate(),
                isRequiredField: true,
                initialEntryMode: DatePickerEntryMode.calendar,
                validator: (_) =>
                    widget.restricaoFormController.indisponibilidade?.periodoInicial.errorMessage ??
                    widget.restricaoFormController.indisponibilidade?.periodoFinal.errorMessage,
                dateTimeRange: (value) {
                  widget.restricaoFormController.indisponibilidade = widget.restricaoFormController.indisponibilidade?.copyWith(
                    periodoInicial: DateVO.date(value!.start),
                    periodoFinal: DateVO.date(value.end),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldWidget(
                label: translation.fields.motivo,
                initialValue: widget.restricaoFormController.indisponibilidade?.motivo.value,
                validator: (_) => widget.restricaoFormController.indisponibilidade?.motivo.errorMessage,
                onChanged: (value) {
                  widget.restricaoFormController.indisponibilidade = widget.restricaoFormController.indisponibilidade?.copyWith(
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
                        label: translation.fields.horarioInicial,
                        initTime: widget.restricaoFormController.indisponibilidade?.horarioInicial.getTime(),
                        validator: (_) => widget.restricaoFormController.indisponibilidade?.horarioInicial.errorMessage,
                        onChanged: (value) {
                          if (value != null) {
                            widget.restricaoFormController.indisponibilidade =
                                widget.restricaoFormController.indisponibilidade?.copyWith(horarioInicial: TimeVO.time(value));
                          }
                        }),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: TimeTextFormFieldWidget(
                        label: translation.fields.horarioFinal,
                        initTime: widget.restricaoFormController.indisponibilidade?.horarioFinal.getTime(),
                        validator: (_) => widget.restricaoFormController.indisponibilidade?.horarioFinal.errorMessage,
                        onChanged: (value) {
                          if (value != null) {
                            widget.restricaoFormController.indisponibilidade =
                                widget.restricaoFormController.indisponibilidade?.copyWith(horarioFinal: TimeVO.time(value));
                          }
                        }),
                  ),
                ],
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
              visible:
                  widget.restricaoFormController.indisponibilidade != null && widget.restricaoFormController.indisponibilidade!.codigo > 0,
              child: CustomTextButton(
                title: translation.fields.excluir,
                textColor: colorTheme?.danger,
                onPressed: () {
                  widget.restricaoFormController.removerIndisponibilidade(widget.restricaoFormController.indisponibilidade?.codigo ?? 0);

                  widget.restricaoFormController.indisponibilidade = null;

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
                  title: translation.fields.cancelar,
                  onPressed: () {
                    widget.restricaoFormController.indisponibilidade = null;

                    Modular.to.pop();
                  },
                ),
                const SizedBox(width: 16),
                CustomPrimaryButton(
                  title: translation.fields.adicionar,
                  onPressed: () {
                    var indisponibilidade = widget.restricaoFormController.indisponibilidade;
                    if (formKey.currentState!.validate() && indisponibilidade != null) {
                      widget.restricaoFormController.criarEditarIndisponibilidade(indisponibilidade);
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
