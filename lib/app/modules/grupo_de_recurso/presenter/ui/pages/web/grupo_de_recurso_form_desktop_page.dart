import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/tipo_de_recurso_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/dropdown_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/controllers/grupo_de_recurso_controller.dart';

import '../../../stores/grupo_de_recurso_form_store.dart';

class GrupoDeRecursoFormDesktopPage extends StatefulWidget {
  final ValueNotifier<GrupoDeRecurso?> oldGrupoDeRecurso;
  final GrupoDeRecursoFormStore grupoDeRecursoFormStore;
  final GrupoDeRecursoController grupoDeRecursoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRecursoFormDesktopPage({
    Key? key,
    required this.oldGrupoDeRecurso,
    required this.grupoDeRecursoFormStore,
    required this.grupoDeRecursoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<GrupoDeRecursoFormDesktopPage> createState() => _GrupoDeRecursoFormDesktopPageState();
}

class _GrupoDeRecursoFormDesktopPageState extends State<GrupoDeRecursoFormDesktopPage> {
  GrupoDeRecursoFormStore get grupoDeRecursoFormStore => widget.grupoDeRecursoFormStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  GrupoDeRecursoController get grupoDeRecursoController => widget.grupoDeRecursoController;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    context.select(() => [grupoDeRecursoController.grupoDeRecurso]);

    final grupoDeRecurso = grupoDeRecursoController.grupoDeRecurso;

    return CustomScaffold.titleString(
      grupoDeRecurso.id == null ? translation.titles.criarGrupoDeRecursos : grupoDeRecurso.descricao.value,
      alignment: Alignment.centerLeft,
      controller: scaffoldController,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.gruposDeRecursosModule.path),
      actions: [
        InternetButtonIconWidget(connectionStore: widget.connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 635),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: NhidsTextFormField(
                          label: translation.fields.codigo,
                          initialValue: grupoDeRecurso.codigo.value,
                          isEnabled: true,
                          isRequiredField: true,
                          onChanged: (value) => grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(
                            codigo: CodigoVO(value),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                          flex: 3,
                          child: TextFormFieldWidget(
                            label: translation.fields.nome,
                            initialValue: grupoDeRecurso.descricao.value,
                            isEnabled: true,
                            isRequiredField: true,
                            onChanged: (value) => grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(
                              descricao: TextVO(value),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonWidget<TipoDeRecursoEnum>(
                    label: translation.fields.tipo,
                    value: grupoDeRecurso.tipo,
                    items: TipoDeRecursoEnum.values
                        .map<DropdownItem<TipoDeRecursoEnum>>((tipo) => DropdownItem(value: tipo, label: tipo.name))
                        .toList(),
                    isRequiredField: true,
                    errorMessage: translation.messages.errorCampoObrigatorio,
                    onSelected: (value) => grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso.copyWith(tipo: value),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: widget.oldGrupoDeRecurso,
        builder: (context, oldGrupoDeRecurso, child) {
          return Visibility(
            visible: grupoDeRecurso.id == null || (grupoDeRecurso.id != null && oldGrupoDeRecurso != grupoDeRecurso),
            child: ContainerNavigationBarWidget(
              child: TripleBuilder<GrupoDeRecursoFormStore, GrupoDeRecurso?>(
                store: widget.grupoDeRecursoFormStore,
                builder: (context, triple) {
                  final id = widget.grupoDeRecursoController.grupoDeRecurso.id;

                  final error = triple.error;
                  if (!triple.isLoading && error != null && error is Failure) {
                    Asuka.showDialog(
                      barrierColor: Colors.black38,
                      builder: (context) {
                        return ErrorModal(errorMessage: (triple.error as Failure).errorMessage ?? '');
                      },
                    );
                  }

                  final grupoDeRecurso = triple.state;
                  if (grupoDeRecurso != null && !triple.isLoading && grupoDeRecurso != oldGrupoDeRecurso) {
                    Asuka.showSnackBar(
                      SnackBar(
                        content: Text(
                          id == null
                              ? translation.messages.criouAEntidadeComSucesso(translation.fields.grupoDeRecurso)
                              : translation.messages.editouAEntidadeComSucesso(translation.fields.grupoDeRecurso),
                          style: AnaTextStyles.grey14Px.copyWith(fontSize: 15, color: Colors.white, letterSpacing: 0.25),
                        ),
                        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.87),
                        behavior: SnackBarBehavior.floating,
                        width: 635,
                      ),
                    );

                    if (id == null) {
                      checkPreviousRouteWeb(NavigationRouter.gruposDeRecursosModule.path);
                    } else {
                      widget.grupoDeRecursoController.grupoDeRecurso = grupoDeRecurso;
                      widget.oldGrupoDeRecurso.value = grupoDeRecursoController.grupoDeRecurso.copyWith();
                      widget.grupoDeRecursoController.grupoDeRecursoNotifyListeners();
                    }
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                        title: id == null ? translation.fields.cancelar : translation.fields.descartar,
                        isEnabled: !triple.isLoading,
                        onPressed: () {
                          if (oldGrupoDeRecurso != widget.grupoDeRecursoController.grupoDeRecurso) {
                            Asuka.showDialog(
                              barrierColor: Colors.black38,
                              builder: (context) {
                                return ConfirmationModalWidget(
                                  title: translation.titles.descartarAlteracoes,
                                  messages: translation.messages.descatarAlteracoesCriacaoEntidade,
                                  titleCancel: translation.fields.descartar,
                                  titleSuccess: translation.fields.continuar,
                                  onCancel: () => checkPreviousRouteWeb(NavigationRouter.gruposDeRecursosModule.path),
                                );
                              },
                            );
                          } else {
                            checkPreviousRouteWeb(NavigationRouter.gruposDeRecursosModule.path);
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      CustomPrimaryButton(
                        title: id != null ? translation.fields.salvar : translation.fields.criar,
                        isLoading: triple.isLoading,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            grupoDeRecursoFormStore.salvar(grupoDeRecursoController.grupoDeRecurso);
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
