// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';

class MobileTurnoTrabalhoDadosGeraisFormWidget extends StatelessWidget {
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final GlobalKey<FormState> formKey;

  const MobileTurnoTrabalhoDadosGeraisFormWidget({
    Key? key,
    required this.turnoTrabalhoFormController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormFieldWidget(
              label: translation.fields.codigo,
              initialValue: turnoTrabalhoFormController.turnoTrabalho.codigo.toText,
              isRequiredField: true,
              isEnabled: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (_) => turnoTrabalhoFormController.turnoTrabalho.codigo.errorMessage,
              onChanged: (value) {
                turnoTrabalhoFormController.turnoTrabalho = turnoTrabalhoFormController.turnoTrabalho.copyWith(
                  codigo: value.isNotEmpty ? CodigoVO.text(value) : CodigoVO(0),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              label: translation.fields.nome,
              initialValue: turnoTrabalhoFormController.turnoTrabalho.nome.value,
              isRequiredField: true,
              isEnabled: true,
              validator: (_) => turnoTrabalhoFormController.turnoTrabalho.nome.errorMessage,
              onChanged: (value) {
                turnoTrabalhoFormController.turnoTrabalho = turnoTrabalhoFormController.turnoTrabalho.copyWith(nome: TextVO(value));
              },
            ),
          ],
        ),
      ),
    );
  }
}
