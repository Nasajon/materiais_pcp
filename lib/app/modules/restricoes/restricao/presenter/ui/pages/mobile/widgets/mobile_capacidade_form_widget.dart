// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/integer_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/enum/tipo_unidade_enum.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';

class MobileCapacidadeFormWidget extends StatelessWidget {
  final RestricaoFormController restricaoFormController;
  final GlobalKey<FormState> formKey;

  const MobileCapacidadeFormWidget({
    Key? key,
    required this.restricaoFormController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomBaseTextField(
              label: l10n.fields.capacidadeDeProducao,
              initialValue: restricaoFormController.restricao.capacidadeProducao.value.toString(),
              isRequiredField: true,
              isEnabled: true,
              validator: (_) => restricaoFormController.restricao.capacidadeProducao.errorMessage,
              onChanged: (value) {
                restricaoFormController.restricao = restricaoFormController.restricao.copyWith(capacidadeProducao: IntegerVO.text(value));
              },
            ),
            CustomCheckBoxWithText(
              text: l10n.fields.limitarCapacidadeDeProducao,
              isChecked: restricaoFormController.restricao.limitarCapacidadeProducao,
              onChanged: (value) => restricaoFormController.restricao = restricaoFormController.restricao.copyWith(
                limitarCapacidadeProducao: value,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonWidget<TipoUnidadeEnum>(
              label: l10n.fields.tipoDeUnidade,
              value: restricaoFormController.restricao.tipoUnidade,
              items: TipoUnidadeEnum.values
                  .map<DropdownItem<TipoUnidadeEnum>>((tipo) => DropdownItem(value: tipo, label: tipo.description))
                  .toList(),
              isRequiredField: true,
              errorMessage: l10n.messages.errorCampoObrigatorio,
              onSelected: (value) => restricaoFormController.restricao = restricaoFormController.restricao.copyWith(tipoUnidade: value),
            ),
            const SizedBox(height: 16),
            MoneyTextFormFieldWidget(
              label: l10n.fields.custoPorHora,
              initialValue: restricaoFormController.restricao.custoPorHora.value,
              isEnabled: true,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                restricaoFormController.restricao = restricaoFormController.restricao.copyWith(
                  custoPorHora: MoedaVO(value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
