import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/entities/horario_entity.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/ui/web/widgets/desktop_card_criar_editar_horario_widget.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/ui/web/widgets/desktop_card_horario_widget.dart';

class DesktopHorarioFormWidget extends StatelessWidget {
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final GlobalKey<FormState> formKey;
  final bool isButtonAtTop;

  const DesktopHorarioFormWidget({
    Key? key,
    required this.turnoTrabalhoFormController,
    required this.formKey,
    this.isButtonAtTop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return RxBuilder(
      builder: (_) {
        Widget addButton = CustomOutlinedButton(
            title: translation.fields.adicionarHorario,
            onPressed: () async {
              turnoTrabalhoFormController.horario = HorarioEntity.empty();
            });

        if (turnoTrabalhoFormController.turnoTrabalho.horarios.isEmpty && turnoTrabalhoFormController.horario == null) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 390),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    translation.titles.adicioneUmHorario,
                    style: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    translation.messages.nenhumHorarioFoiAdicionada,
                    textAlign: TextAlign.center,
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  addButton,
                ],
              ),
            ),
          );
        }

        int index = 0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Visibility(
                visible: isButtonAtTop && turnoTrabalhoFormController.horario == null,
                child: addButton,
              ),
            ),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ...turnoTrabalhoFormController.turnoTrabalho.horarios.map((horario) {
                  index++;
                  if (turnoTrabalhoFormController.horario?.codigo == index) {
                    return DesktopCardCriarEditarHorarioWidget(
                      turnoTrabalhoFormController: turnoTrabalhoFormController,
                      formKey: formKey,
                    );
                  }

                  return DesktopCardHorarioWidget(
                    turnoTrabalhoFormController: turnoTrabalhoFormController,
                    horario: horario,
                  );
                }).toList(),
                if (turnoTrabalhoFormController.horario?.codigo == 0) ...[
                  DesktopCardCriarEditarHorarioWidget(
                    turnoTrabalhoFormController: turnoTrabalhoFormController,
                    formKey: formKey,
                  ),
                ]
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Visibility(
                visible: !isButtonAtTop && turnoTrabalhoFormController.horario == null,
                child: addButton,
              ),
            )
          ],
        );
      },
    );
  }
}
