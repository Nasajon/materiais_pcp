// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/turno_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_turno_de_trabalho_store.dart';

class DesktopRestricaoDadosGeraisFormWidget extends StatelessWidget {
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetTurnoDeTrabalhoStore getTurnoDeTrabalhoStore;
  final RestricaoFormController restricaoFormController;
  final GlobalKey<FormState> formKey;

  const DesktopRestricaoDadosGeraisFormWidget({
    Key? key,
    required this.getGrupoDeRestricaoStore,
    required this.getCentroDeTrabalhoStore,
    required this.getTurnoDeTrabalhoStore,
    required this.restricaoFormController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    return RxBuilder(
      builder: (context) {
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
                          initialValue: restricaoFormController.restricao.codigo.value,
                          isRequiredField: true,
                          isEnabled: true,
                          validator: (_) => restricaoFormController.restricao.codigo.errorMessage,
                          onChanged: (value) {
                            restricaoFormController.restricao = restricaoFormController.restricao.copyWith(
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
                        child: AutocompleteTextFormField<RestricaoGrupoDeRestricaoEntity>(
                          initialSelectedValue: restricaoFormController.restricao.grupoDeRestricao,
                          itemTextValue: (value) => value.nome,
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(
                              labelText: translation.fields.grupoDeRecurso,
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return getGrupoDeRestricaoStore.getGruposDeRestricao(pattern);
                          },
                          suggestionsForNextPageCallback: (pattern, lastObject) async {
                            return await getGrupoDeRestricaoStore.getGruposDeRestricao(pattern, ultimoGrupoDeRestricaoId: lastObject.id);
                          },
                          itemBuilder: (context, grupo) {
                            return ListTile(
                              title: Text(grupo.nome),
                            );
                          },
                          errorBuilder: (context, error) {
                            return Text(error.toString());
                          },
                          validator: (value) {
                            if (restricaoFormController.restricao.grupoDeRestricao == RestricaoGrupoDeRestricaoEntity.empty()) {
                              return translation.messages.errorCampoObrigatorio;
                            }

                            return null;
                          },
                          onSelected: (value) {
                            restricaoFormController.restricao = restricaoFormController.restricao.copyWith(grupoDeRestricao: value);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: AutocompleteTextFormField<RestricaoCentroDeTrabalho>(
                          initialSelectedValue: restricaoFormController.restricao.centroDeTrabalho,
                          itemTextValue: (value) => value.nome,
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(
                              labelText: translation.fields.centroDeTrabalho,
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return getCentroDeTrabalhoStore.getCentro(pattern);
                          },
                          suggestionsForNextPageCallback: (pattern, lastObject) async {
                            return await getCentroDeTrabalhoStore.getCentro(pattern, ultimoCentroDeTrabalhoId: lastObject.id);
                          },
                          itemBuilder: (context, centroTrabalho) {
                            return ListTile(
                              title: Text(centroTrabalho.nome),
                            );
                          },
                          errorBuilder: (context, error) {
                            return Text(error.toString());
                          },
                          validator: (value) {
                            if (restricaoFormController.restricao.centroDeTrabalho == RestricaoCentroDeTrabalho.empty()) {
                              return translation.messages.errorCampoObrigatorio;
                            }

                            return null;
                          },
                          onSelected: (value) {
                            restricaoFormController.restricao = restricaoFormController.restricao.copyWith(
                              centroDeTrabalho: value ?? RestricaoCentroDeTrabalho.empty(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ChipsTextField<TurnoDeTrabalhoEntity>(
                    label: translation.fields.turnosDeTrabalho,
                    initialValue: restricaoFormController.restricao.turnos,
                    chip: (value) => Chip(
                      key: ValueKey(value.id),
                      label: Text(
                        value.nome,
                        style: themeData.textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      deleteIcon: Icon(
                        Icons.close,
                        color: colorTheme?.field,
                        size: 12,
                      ),
                      deleteIconColor: Colors.transparent,
                      onDeleted: () {
                        final turnos = restricaoFormController.restricao.turnos;

                        turnos.removeWhere(
                          (turno) => turno.id == value.id,
                        );

                        restricaoFormController.restricao = restricaoFormController.restricao.copyWith(turnos: turnos);
                      },
                    ),
                    suggestionsCallback: (pattern) async {
                      if (restricaoFormController.restricao.centroDeTrabalho != RestricaoCentroDeTrabalho.empty()) {
                        return getTurnoDeTrabalhoStore.getTurnoPorCentroDeTrabalho(
                          restricaoFormController.restricao.centroDeTrabalho.id,
                          search: pattern,
                          turnos: restricaoFormController.restricao.turnos,
                        );
                      }

                      return [];
                    },
                    itemBuilder: (context, centroTrabalho) {
                      return ListTile(
                        title: Text(centroTrabalho.nome),
                      );
                    },
                    errorBuilder: (context, error) {
                      return Text(error.toString());
                    },
                    onSelected: (value) {
                      restricaoFormController.restricao = restricaoFormController.restricao.copyWith(turnos: value);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
