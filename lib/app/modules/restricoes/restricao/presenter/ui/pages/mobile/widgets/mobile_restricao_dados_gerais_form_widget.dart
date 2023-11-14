// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_grupo_de_restricao_store.dart';

class MobileRestricaoDadosGeraisFormWidget extends StatelessWidget {
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final RestricaoFormController restricaoFormController;
  final GlobalKey<FormState> formKey;

  const MobileRestricaoDadosGeraisFormWidget({
    Key? key,
    required this.getGrupoDeRestricaoStore,
    required this.restricaoFormController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormFieldWidget(
              label: translation.fields.codigo,
              initialValue: restricaoFormController.restricao.codigo.toText,
              isRequiredField: true,
              isEnabled: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (_) => restricaoFormController.restricao.codigo.errorMessage,
              onChanged: (value) {
                restricaoFormController.restricao = restricaoFormController.restricao.copyWith(
                  codigo: value.isNotEmpty ? CodigoVO.text(value) : CodigoVO(0),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              label: translation.fields.nome,
              initialValue: restricaoFormController.restricao.descricao.value,
              isRequiredField: true,
              isEnabled: true,
              validator: (_) => restricaoFormController.restricao.descricao.errorMessage,
              onChanged: (value) {
                restricaoFormController.restricao = restricaoFormController.restricao.copyWith(descricao: TextVO(value));
              },
            ),
            const SizedBox(height: 16),
            ScopedBuilder<GetGrupoDeRestricaoStore, List<GrupoDeRestricaoEntity>>(
              store: getGrupoDeRestricaoStore,
              onLoading: (context) => DropdownLoadWidget(label: translation.fields.grupoDeRestricao),
              onState: (_, grupos) {
                return DropdownButtonWidget<GrupoDeRestricaoEntity>(
                  label: translation.fields.grupoDeRestricao,
                  value: grupos.isNotEmpty ? restricaoFormController.restricao.grupoDeRestricao : null,
                  isRequiredField: true,
                  errorMessage: translation.messages.errorCampoObrigatorio,
                  isEnabled: true,
                  items: grupos
                      .map((grupoDeRestricao) => DropdownItem(value: grupoDeRestricao, label: grupoDeRestricao.descricao.value))
                      .toList(),
                  onSelected: (value) =>
                      restricaoFormController.restricao = restricaoFormController.restricao.copyWith(grupoDeRestricao: value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
