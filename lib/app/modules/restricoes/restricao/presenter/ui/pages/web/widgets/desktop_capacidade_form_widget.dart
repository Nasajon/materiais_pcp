import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/integer_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/enum/tipo_unidade_enum.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';

class DesktopCapacidadeFormWidget extends StatelessWidget {
  final RestricaoFormController restricaoFormController;

  const DesktopCapacidadeFormWidget({
    Key? key,
    required this.restricaoFormController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 635),
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBaseTextField(
                          label: 'Capacidade de produção',
                          initialValue: restricaoFormController.restricao.capacidadeProducao.value.toString(),
                          isRequiredField: true,
                          isEnabled: true,
                          validator: (_) => restricaoFormController.restricao.capacidadeProducao.errorMessage,
                          onChanged: (value) {
                            restricaoFormController.restricao =
                                restricaoFormController.restricao.copyWith(capacidadeProducao: IntegerVO.text(value));
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 2,
                    child: DropdownButtonWidget<TipoUnidadeEnum>(
                      label: 'Tipo de unidade',
                      value: restricaoFormController.restricao.tipoUnidade,
                      items: TipoUnidadeEnum.values
                          .map<DropdownItem<TipoUnidadeEnum>>((tipo) => DropdownItem(value: tipo, label: tipo.description))
                          .toList(),
                      isRequiredField: true,
                      errorMessage: 'error',
                      onSelected: (value) =>
                          restricaoFormController.restricao = restricaoFormController.restricao.copyWith(tipoUnidade: value),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: CustomCheckBoxWithText(
                  text: 'Limitar capacidade de produção',
                  isChecked: restricaoFormController.restricao.limitarCapacidadeProducao,
                  onChanged: (value) => restricaoFormController.restricao = restricaoFormController.restricao.copyWith(
                    limitarCapacidadeProducao: value,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: MoneyTextFormFieldWidget(
                  label: 'Custo por hora',
                  initialValue: restricaoFormController.restricao.custoPorHora.value,
                  isEnabled: true,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    restricaoFormController.restricao = restricaoFormController.restricao.copyWith(
                      custoPorHora: MoedaVO(value),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
