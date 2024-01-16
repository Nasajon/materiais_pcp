// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/entities/turno_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/get_turno_de_trabalho_store.dart';

import '../../../stores/recurso_form_store.dart';

class RecursoFormMobilePage extends StatefulWidget {
  final RxNotifier<Recurso?> oldRecurso;
  final RecursoFormStore recursoFormStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetTurnoDeTrabalhoStore getTurnoDeTrabalhoStore;
  final RecursoController recursoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;
  final GlobalKey<FormState> formKey;

  const RecursoFormMobilePage({
    Key? key,
    required this.oldRecurso,
    required this.recursoFormStore,
    required this.getGrupoDeRecursoStore,
    required this.getCentroDeTrabalhoStore,
    required this.getTurnoDeTrabalhoStore,
    required this.recursoController,
    required this.connectionStore,
    required this.scaffoldController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<RecursoFormMobilePage> createState() => _RecursoFormMobilePageState();
}

class _RecursoFormMobilePageState extends State<RecursoFormMobilePage> {
  String? get id => widget.recursoController.recurso.id;

  late final Disposer recursoFormDisposer;
  final isLoadingNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    recursoFormDisposer = widget.recursoFormStore.observer(
      onLoading: (value) => isLoadingNotifier.value = value,
      onError: (error) async {
        await Asuka.showDialog(
          barrierColor: Colors.black38,
          builder: (context) {
            return ErrorModal(errorMessage: (error as Failure).errorMessage ?? '');
          },
        );
        isLoadingNotifier.value = false;
      },
      onState: (state) {
        if (state != null && state != widget.oldRecurso.value) {
          Asuka.showSnackBar(
            SnackBar(
              content: Text(
                id == null
                    ? translation.messages.criouAEntidadeComSucesso(translation.fields.recurso)
                    : translation.messages.editouAEntidadeComSucesso(translation.fields.recurso),
                style: AnaTextStyles.grey14Px.copyWith(fontSize: 15, color: Colors.white, letterSpacing: 0.25),
              ),
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0.87),
              behavior: SnackBarBehavior.floating,
              width: 635,
            ),
          );

          if (id == null) {
            Modular.to.pop();
          } else {
            widget.recursoController.recurso = state;
            widget.oldRecurso.value = widget.recursoController.recurso.copyWith();
            widget.recursoController.recursoNotifyListeners();
          }
        }

        isLoadingNotifier.value = false;
      },
    );
  }

  @override
  void dispose() {
    recursoFormDisposer();
    isLoadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [widget.recursoController.recurso]);

    final recurso = widget.recursoController.recurso;

    return CustomScaffold.titleString(
      recurso.id == null ? translation.titles.criarRecurso : widget.oldRecurso.value?.descricao.value ?? '',
      alignment: Alignment.centerLeft,
      controller: widget.scaffoldController,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.recursosModule.path),
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 24),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntegerTextFormFieldWidget(
                        label: translation.fields.codigo,
                        initialValue: widget.recursoController.recurso.codigo.value,
                        isRequiredField: true,
                        isEnabled: widget.recursoController.isEnabled,
                        onChanged: (value) => widget.recursoController.recurso = widget.recursoController.recurso.copyWith(
                          codigo: CodigoVO(value),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormFieldWidget(
                        label: translation.fields.nome,
                        initialValue: widget.recursoController.recurso.descricao.value,
                        isRequiredField: true,
                        isEnabled: widget.recursoController.isEnabled,
                        onChanged: (value) => widget.recursoController.recurso = widget.recursoController.recurso.copyWith(
                          descricao: TextVO(value),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AutocompleteTextFormField<RecursoGrupoDeRecurso>(
                        initialSelectedValue: widget.recursoController.recurso.grupoDeRecurso,
                        itemTextValue: (value) => value.nome,
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            labelText: translation.fields.grupoDeRecurso,
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return widget.getGrupoDeRecursoStore.getGrupoDeRecurso(pattern);
                        },
                        suggestionsForNextPageCallback: (pattern, lastObject) async {
                          return await widget.getGrupoDeRecursoStore.getGrupoDeRecurso(pattern, ultimoGrupoDeRecursoId: lastObject.id);
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
                          if (widget.recursoController.recurso.grupoDeRecurso == RecursoGrupoDeRecurso.empty()) {
                            return translation.messages.errorCampoObrigatorio;
                          }

                          return null;
                        },
                        onSelected: (value) {
                          widget.recursoController.recurso = widget.recursoController.recurso.copyWith(
                            grupoDeRecurso: value ?? RecursoGrupoDeRecurso.empty(),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      AutocompleteTextFormField<RecursoCentroDeTrabalho>(
                        initialSelectedValue: widget.recursoController.recurso.centroDeTrabalho,
                        itemTextValue: (value) => value.nome,
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            labelText: translation.fields.centroDeTrabalho,
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return widget.getCentroDeTrabalhoStore.getCentro(pattern);
                        },
                        suggestionsForNextPageCallback: (pattern, lastObject) async {
                          return await widget.getCentroDeTrabalhoStore.getCentro(pattern, ultimoCentroDeTrabalhoId: lastObject.id);
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
                          if (widget.recursoController.recurso.centroDeTrabalho == RecursoCentroDeTrabalho.empty()) {
                            return translation.messages.errorCampoObrigatorio;
                          }

                          return null;
                        },
                        onSelected: (value) {
                          widget.recursoController.recurso = widget.recursoController.recurso.copyWith(
                            centroDeTrabalho: value ?? RecursoCentroDeTrabalho.empty(),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      ChipsTextField<TurnoDeTrabalhoEntity>(
                        label: translation.fields.turnosDeTrabalho,
                        initialValue: widget.recursoController.recurso.turnos,
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
                            final turnos = widget.recursoController.recurso.turnos;

                            turnos.removeWhere(
                              (turno) => turno.id == value.id,
                            );

                            widget.recursoController.recurso = widget.recursoController.recurso.copyWith(turnos: turnos);
                          },
                        ),
                        suggestionsCallback: (pattern) async {
                          if (widget.recursoController.recurso.centroDeTrabalho != RecursoCentroDeTrabalho.empty()) {
                            return widget.getTurnoDeTrabalhoStore.getTurnoPorCentroDeTrabalho(
                              widget.recursoController.recurso.centroDeTrabalho.id,
                              search: pattern,
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
                        // validator: (value) {
                        //   if (widget.recursoController.recurso.centroDeTrabalho == null) {
                        //     return translation.messages.errorCampoObrigatorio;
                        //   }

                        //   return null;
                        // },
                        onSelected: (value) {
                          widget.recursoController.recurso = widget.recursoController.recurso.copyWith(turnos: value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: widget.oldRecurso,
        builder: (context, oldRecurso, child) {
          return Visibility(
            visible: recurso.id == null || (recurso.id != null && oldRecurso != recurso),
            child: ContainerNavigationBarWidget(
              child: ValueListenableBuilder(
                valueListenable: isLoadingNotifier,
                builder: (_, isLoading, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                        title: id == null ? translation.fields.cancelar : translation.fields.descartar,
                        isEnabled: !isLoading,
                        onPressed: () {
                          if (oldRecurso != widget.recursoController.recurso) {
                            Asuka.showDialog(
                              barrierColor: Colors.black38,
                              builder: (context) {
                                return ConfirmationModalWidget(
                                  title: translation.titles.descartarAlteracoes,
                                  messages: translation.messages.descatarAlteracoesCriacaoEntidade,
                                  titleCancel: translation.fields.descartar,
                                  titleSuccess: translation.fields.continuar,
                                  onCancel: () => checkPreviousRouteWeb(NavigationRouter.recursosModule.path),
                                );
                              },
                            );
                          } else {
                            checkPreviousRouteWeb(NavigationRouter.recursosModule.path);
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      CustomPrimaryButton(
                        title: id != null ? translation.fields.salvar : translation.fields.criar,
                        isLoading: isLoading,
                        onPressed: () async {
                          if (widget.formKey.currentState!.validate()) {
                            widget.recursoFormStore.salvar(widget.recursoController.recurso);
                          }
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
