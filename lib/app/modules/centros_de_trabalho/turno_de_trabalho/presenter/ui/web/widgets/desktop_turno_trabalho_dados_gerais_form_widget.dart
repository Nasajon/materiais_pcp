import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';

class DesktopTurnoTrabalhoDadosGeraisFormWidget extends StatelessWidget {
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final GlobalKey<FormState> formKey;

  const DesktopTurnoTrabalhoDadosGeraisFormWidget({
    Key? key,
    required this.turnoTrabalhoFormController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 635),
        padding: const EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: IntegerTextFormFieldWidget(
                      label: translation.fields.codigo,
                      initialValue: turnoTrabalhoFormController.turnoTrabalho.codigo.value,
                      isRequiredField: true,
                      isEnabled: true,
                      validator: (_) => turnoTrabalhoFormController.turnoTrabalho.codigo.errorMessage,
                      onChanged: (value) {
                        turnoTrabalhoFormController.turnoTrabalho = turnoTrabalhoFormController.turnoTrabalho.copyWith(
                          codigo: CodigoVO(value),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 3,
                    child: TextFormFieldWidget(
                      label: translation.fields.nome,
                      initialValue: turnoTrabalhoFormController.turnoTrabalho.nome.value,
                      isRequiredField: true,
                      isEnabled: true,
                      validator: (_) => turnoTrabalhoFormController.turnoTrabalho.nome.errorMessage,
                      onChanged: (value) {
                        turnoTrabalhoFormController.turnoTrabalho = turnoTrabalhoFormController.turnoTrabalho.copyWith(nome: TextVO(value));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
