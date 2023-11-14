// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/get_grupo_de_recurso_store.dart';

import '../../../stores/recurso_form_store.dart';

class RecursoFormMobilePage extends StatefulWidget {
  final RxNotifier<Recurso?> oldRecurso;
  final RecursoFormStore recursoFormStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
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
    required this.recursoController,
    required this.connectionStore,
    required this.scaffoldController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<RecursoFormMobilePage> createState() => _RecursoFormMobilePageState();
}

class _RecursoFormMobilePageState extends State<RecursoFormMobilePage> {
  @override
  Widget build(BuildContext context) {
    context.select(() => [widget.recursoController.recurso]);

    final recurso = widget.recursoController.recurso;

    return CustomScaffold.titleString(
      recurso.id == null ? translation.titles.criarRecurso : widget.oldRecurso.value?.descricao.value ?? '',
      alignment: Alignment.centerLeft,
      controller: widget.scaffoldController,
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
                      ScopedBuilder<GetGrupoDeRecursoStore, List<GrupoDeRecurso>>(
                        store: widget.getGrupoDeRecursoStore,
                        onLoading: (context) => DropdownLoadWidget(label: translation.fields.grupoDeRecurso),
                        onState: (_, grupos) {
                          return DropdownButtonWidget<GrupoDeRecurso>(
                            label: translation.fields.grupoDeRecurso,
                            value: grupos.isNotEmpty ? widget.recursoController.recurso.grupoDeRecurso : null,
                            isRequiredField: true,
                            errorMessage: translation.messages.errorCampoObrigatorio,
                            isEnabled: widget.recursoController.isEnabled,
                            items: grupos
                                .map((grupoDeRecurso) => DropdownItem(value: grupoDeRecurso, label: grupoDeRecurso.descricao.value))
                                .toList(),
                            onSelected: (value) =>
                                widget.recursoController.recurso = widget.recursoController.recurso.copyWith(grupoDeRecurso: value),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      ScopedBuilder<GetCentroDeTrabalhoStore, List<RecursoCentroDeTrabalho>>(
                        store: widget.getCentroDeTrabalhoStore,
                        onLoading: (context) => DropdownLoadWidget(label: translation.fields.centroDeTrabalho),
                        onState: (_, centros) {
                          return DropdownButtonWidget<RecursoCentroDeTrabalho>(
                            label: translation.fields.centroDeTrabalho,
                            value: centros.isNotEmpty ? widget.recursoController.recurso.centroDeTrabalho : null,
                            isRequiredField: true,
                            errorMessage: translation.messages.errorCampoObrigatorio,
                            isEnabled: widget.recursoController.isEnabled,
                            items: centros
                                .map((centroDeTrabalho) => DropdownItem(value: centroDeTrabalho, label: centroDeTrabalho.nome))
                                .toList(),
                            onSelected: (value) =>
                                widget.recursoController.recurso = widget.recursoController.recurso.copyWith(centroDeTrabalho: value),
                          );
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
              child: TripleBuilder<RecursoFormStore, Recurso?>(
                store: widget.recursoFormStore,
                builder: (context, triple) {
                  final id = widget.recursoController.recurso.id;

                  final error = triple.error;
                  if (!triple.isLoading && error != null && error is Failure) {
                    Asuka.showDialog(
                      barrierColor: Colors.black38,
                      builder: (context) {
                        return ErrorModal(errorMessage: (triple.error as Failure).errorMessage ?? '');
                      },
                    );
                  }

                  final recurso = triple.state;
                  if (recurso != null && !triple.isLoading && recurso != oldRecurso) {
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
                      widget.recursoController.recurso = recurso;
                      widget.oldRecurso.value = widget.recursoController.recurso.copyWith();
                      widget.recursoController.recursoNotifyListeners();
                    }
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                        title: id == null ? translation.fields.cancelar : translation.fields.descartar,
                        isEnabled: !triple.isLoading,
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
                                  onCancel: () => Modular.to.pop(),
                                );
                              },
                            );
                          } else {
                            Modular.to.pop();
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      CustomPrimaryButton(
                        title: id != null ? translation.fields.salvar : translation.fields.criar,
                        isLoading: triple.isLoading,
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
