import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';

class MobileCriarEditarIndisponibilidade extends StatelessWidget {
  final RestricaoFormController restricaoFormController;

  MobileCriarEditarIndisponibilidade({
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
      restricaoFormController.indisponibilidade != null && restricaoFormController.indisponibilidade?.codigo == 0
          ? l10n.titles.adicionarIndisponibilidade
          : l10n.titles.editarIndisponibilidade,
      controller: CustomScaffoldController(),
      alignment: Alignment.centerLeft,
      onIconTap: () {
        restricaoFormController.indisponibilidade = null;

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
                initDateStart: restricaoFormController.indisponibilidade?.periodoInicial.getDate(),
                initDateEnd: restricaoFormController.indisponibilidade?.periodoFinal.getDate(),
                isRequiredField: true,
                initialEntryMode: DatePickerEntryMode.calendar,
                validator: (_) =>
                    restricaoFormController.indisponibilidade?.periodoInicial.errorMessage ??
                    restricaoFormController.indisponibilidade?.periodoFinal.errorMessage,
                dateTimeRange: (value) {
                  restricaoFormController.indisponibilidade = restricaoFormController.indisponibilidade?.copyWith(
                    periodoInicial: DateVO.date(value!.start),
                    periodoFinal: DateVO.date(value.end),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldWidget(
                label: l10n.fields.motivo,
                initialValue: restricaoFormController.indisponibilidade?.motivo.value,
                validator: (_) => restricaoFormController.indisponibilidade?.motivo.errorMessage,
                onChanged: (value) {
                  restricaoFormController.indisponibilidade = restricaoFormController.indisponibilidade?.copyWith(
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
                        initTime: restricaoFormController.indisponibilidade?.horarioInicial.getTime(),
                        validator: (_) => restricaoFormController.indisponibilidade?.horarioInicial.errorMessage,
                        onChanged: (value) {
                          if (value != null) {
                            restricaoFormController.indisponibilidade =
                                restricaoFormController.indisponibilidade?.copyWith(horarioInicial: TimeVO.time(value));
                          }
                        }),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: TimeTextFormFieldWidget(
                        label: l10n.fields.horarioFinal,
                        initTime: restricaoFormController.indisponibilidade?.horarioFinal.getTime(),
                        validator: (_) => restricaoFormController.indisponibilidade?.horarioFinal.errorMessage,
                        onChanged: (value) {
                          if (value != null) {
                            restricaoFormController.indisponibilidade =
                                restricaoFormController.indisponibilidade?.copyWith(horarioFinal: TimeVO.time(value));
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
              visible: restricaoFormController.indisponibilidade != null && restricaoFormController.indisponibilidade!.codigo > 0,
              child: CustomTextButton(
                title: l10n.fields.excluir,
                textColor: colorTheme?.danger,
                onPressed: () {
                  restricaoFormController.removerIndisponibilidade(restricaoFormController.indisponibilidade?.codigo ?? 0);

                  restricaoFormController.indisponibilidade = null;

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
                    restricaoFormController.indisponibilidade = null;

                    Modular.to.pop();
                  },
                ),
                const SizedBox(width: 16),
                CustomPrimaryButton(
                  title: l10n.fields.adicionar,
                  onPressed: () {
                    var indisponibilidade = restricaoFormController.indisponibilidade;
                    if (formKey.currentState!.validate() && indisponibilidade != null) {
                      restricaoFormController.criarEditarIndisponibilidade(indisponibilidade);
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
