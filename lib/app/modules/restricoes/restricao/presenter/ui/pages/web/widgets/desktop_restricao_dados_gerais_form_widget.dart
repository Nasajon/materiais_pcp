// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/stores/get_grupo_de_restricao_store.dart';

class DesktopRestricaoDadosGeraisFormWidget extends StatelessWidget {
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final RestricaoFormController restricaoFormController;

  const DesktopRestricaoDadosGeraisFormWidget({
    Key? key,
    required this.getGrupoDeRestricaoStore,
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
                    child: CustomBaseTextField(
                      label: 'Código',
                      initialValue: restricaoFormController.restricao.codigo?.toText,
                      isRequiredField: true,
                      isEnabled: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (_) => restricaoFormController.restricao.codigo?.errorMessage,
                      onChanged: (value) {
                        restricaoFormController.restricao = restricaoFormController.restricao.copyWith(
                          codigo: value.isNotEmpty ? CodigoVO.text(value) : CodigoVO(0),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 3,
                    child: CustomBaseTextField(
                      label: 'Nome',
                      initialValue: restricaoFormController.restricao.descricao.value,
                      isRequiredField: true,
                      isEnabled: true,
                      validator: (_) => restricaoFormController.restricao.descricao.errorMessage,
                      onChanged: (value) {
                        restricaoFormController.restricao = restricaoFormController.restricao.copyWith(descricao: TextVO(value));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: ScopedBuilder<GetGrupoDeRestricaoStore, List<GrupoDeRestricaoEntity>>(
                      store: getGrupoDeRestricaoStore,
                      onLoading: (context) => DropdownLoadWidget(label: 'Grupo de Restrição'),
                      onState: (_, grupos) {
                        return DropdownButtonWidget<GrupoDeRestricaoEntity>(
                          label: 'Grupo de Restrição',
                          value: grupos.isNotEmpty ? restricaoFormController.restricao.grupoDeRestricao : null,
                          isRequiredField: true,
                          errorMessage: 'error',
                          isEnabled: true,
                          items: grupos
                              .map((grupoDeRestricao) => DropdownItem(value: grupoDeRestricao, label: grupoDeRestricao.descricao.value))
                              .toList(),
                          onSelected: (value) =>
                              restricaoFormController.restricao = restricaoFormController.restricao.copyWith(grupoDeRestricao: value),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: ScopedBuilder<GetGrupoDeRestricaoStore, List<GrupoDeRestricaoEntity>>(
                      store: getGrupoDeRestricaoStore,
                      onLoading: (context) => DropdownLoadWidget(label: 'Centro de trabalho'),
                      onState: (_, grupos) {
                        return DropdownButtonWidget<GrupoDeRestricaoEntity>(
                          label: 'Centro de trabalho',
                          value: grupos.isNotEmpty ? restricaoFormController.restricao.grupoDeRestricao : null,
                          isRequiredField: true,
                          errorMessage: 'error',
                          isEnabled: true,
                          items: grupos
                              .map((grupoDeRestricao) => DropdownItem(value: grupoDeRestricao, label: grupoDeRestricao.descricao.value))
                              .toList(),
                          onSelected: (value) =>
                              restricaoFormController.restricao = restricaoFormController.restricao.copyWith(grupoDeRestricao: value),
                        );
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
