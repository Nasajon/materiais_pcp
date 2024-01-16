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
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/controllers/centro_trabalho_controller.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/stores/centro_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/stores/inserir_editar_centro_trabalho_store.dart';

class CentroTrabalhoFormDesktopPage extends StatefulWidget {
  final String? id;
  final InserirEditarCentroTrabalhoStore inserirEditarCentroTrabalhoStore;
  final CentroTrabalhoListStore centroTrabalhoListStore;
  final CentroTrabalhoController centroTrabalhoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const CentroTrabalhoFormDesktopPage({
    Key? key,
    this.id,
    required this.inserirEditarCentroTrabalhoStore,
    required this.centroTrabalhoListStore,
    required this.centroTrabalhoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<CentroTrabalhoFormDesktopPage> createState() => _CentroTrabalhoFormDesktopPageState();
}

class _CentroTrabalhoFormDesktopPageState extends State<CentroTrabalhoFormDesktopPage> {
  InserirEditarCentroTrabalhoStore get inserirEditarCentroTrabalhoStore => widget.inserirEditarCentroTrabalhoStore;
  CentroTrabalhoController get centroTrabalhoController => widget.centroTrabalhoController;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;

  final _formKey = GlobalKey<FormState>();

  CentroTrabalhoAggregate oldCentroTrabalho = CentroTrabalhoAggregate.empty();

  @override
  void initState() {
    super.initState();

    centroTrabalhoController.isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final id = widget.id;
      // TODO: adicionar a busca dos turnos
      if (id != null && centroTrabalhoController.centroTrabalho.id != id) {
        final centroTrabalho = await inserirEditarCentroTrabalhoStore.buscarCentroTrabalho(id);

        if (centroTrabalho != null) {
          oldCentroTrabalho = centroTrabalho;
          centroTrabalhoController.centroTrabalho = oldCentroTrabalho.copyWith();
        } else {
          // TODO: Mensagem para quando não encontrar o centro trabalho
          checkPreviousRouteWeb(NavigationRouter.centrosDeTrabalhosModule.path);
        }
      }
      centroTrabalhoController.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    context.select(() => [
          centroTrabalhoController.centroTrabalho,
          centroTrabalhoController.isEnabled,
          centroTrabalhoController.isLoading,
          centroTrabalhoController.turnosDeTrabalho,
        ]);

    if (centroTrabalhoController.isLoading) {
      return Center(child: CircularProgressIndicator(color: colorTheme?.primary));
    }

    final centroDeTrabalho = centroTrabalhoController.centroTrabalho;

    return CustomScaffold.titleString(
      widget.id == null ? translation.titles.criarCentroDeTrabalho : centroTrabalhoController.centroTrabalho.nome.value,
      alignment: Alignment.centerLeft,
      controller: scaffoldController,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.centrosDeTrabalhosModule.path),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: IntegerTextFormFieldWidget(
                          label: translation.fields.codigo,
                          initialValue: centroDeTrabalho.codigo.value,
                          isRequiredField: true,
                          isEnabled: centroTrabalhoController.isEnabled,
                          onChanged: (value) {
                            centroTrabalhoController.centroTrabalho = centroDeTrabalho.copyWith(codigo: CodigoVO(value));
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        flex: 3,
                        child: TextFormFieldWidget(
                          label: translation.fields.nome,
                          initialValue: centroDeTrabalho.nome.value,
                          isRequiredField: true,
                          isEnabled: centroTrabalhoController.isEnabled,
                          onChanged: (value) {
                            centroTrabalhoController.centroTrabalho = centroDeTrabalho.copyWith(
                              nome: TextVO(value),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ChipsTextField<TurnoTrabalhoEntity>(
                    key: ValueKey('turno-de-trabalho-${centroDeTrabalho.turnos.length}'),
                    label: translation.fields.turnosDeTrabalho,
                    initialValue: centroDeTrabalho.turnos,
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
                        centroDeTrabalho.turnos.removeWhere(
                          (turno) => turno.id == value.id,
                        );

                        centroTrabalhoController.centroTrabalho = centroDeTrabalho;
                      },
                    ),
                    suggestionsCallback: (value) {
                      final turnos = <TurnoTrabalhoEntity>[...centroTrabalhoController.turnosDeTrabalho];

                      centroTrabalhoController.centroTrabalho.turnos.forEach(
                        (turno) => turnos.removeWhere(
                          (element) => element.id == turno.id,
                        ),
                      );

                      if (value.isNotEmpty) {
                        return turnos
                            .where(
                              (turno) => '${turno.codigo} - ${turno.nome}'.toLowerCase().contains(value.toLowerCase()),
                            )
                            .toList();
                      }

                      return turnos;
                    },
                    itemBuilder: (context, itemData) {
                      return ListTile(
                        title: Text(itemData.nome),
                      );
                    },
                    onSelected: (values) {
                      centroTrabalhoController.centroTrabalho = centroDeTrabalho.copyWith(turnos: values);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.id == null || (widget.id != null && oldCentroTrabalho != widget.centroTrabalhoController.centroTrabalho)
          ? ContainerNavigationBarWidget(
              child: TripleBuilder<InserirEditarCentroTrabalhoStore, CentroTrabalhoAggregate?>(
                store: widget.inserirEditarCentroTrabalhoStore,
                builder: (context, triple) {
                  final error = triple.error;
                  if (!triple.isLoading && error != null && error is Failure) {
                    Asuka.showDialog(
                      barrierColor: Colors.black38,
                      builder: (context) {
                        return ErrorModal(errorMessage: (triple.error as Failure).errorMessage ?? '');
                      },
                    );
                  }

                  final centroDeTrabalho = triple.state;
                  if (centroDeTrabalho != null && !triple.isLoading && centroDeTrabalho != oldCentroTrabalho) {
                    Asuka.showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.id == null
                              ? translation.messages.criouAEntidadeComSucesso(translation.fields.centroDeTrabalho)
                              : translation.messages.editouAEntidadeComSucesso(translation.fields.centroDeTrabalho),
                          style: AnaTextStyles.grey14Px.copyWith(fontSize: 15, color: Colors.white, letterSpacing: 0.25),
                        ),
                        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.87),
                        behavior: SnackBarBehavior.floating,
                        width: 635,
                      ),
                    );

                    if (widget.id == null) {
                      oldCentroTrabalho = centroDeTrabalho;
                      widget.centroTrabalhoListStore.addCentroTrabalho(centroDeTrabalho);
                      checkPreviousRouteWeb(NavigationRouter.centrosDeTrabalhosModule.path);
                    } else {
                      widget.centroTrabalhoController.centroTrabalho = centroDeTrabalho;
                      oldCentroTrabalho = centroTrabalhoController.centroTrabalho.copyWith();
                      widget.centroTrabalhoController.centroTrabalhoNotifyListeners();
                      widget.centroTrabalhoListStore.updateCentroTrabalho(oldCentroTrabalho);
                    }
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                          title: widget.id == null ? translation.fields.cancelar : translation.fields.descartar,
                          isEnabled: centroTrabalhoController.isEnabled,
                          onPressed: () {
                            if (oldCentroTrabalho != widget.centroTrabalhoController.centroTrabalho) {
                              Asuka.showDialog(
                                barrierColor: Colors.black38,
                                builder: (context) {
                                  return ConfirmationModalWidget(
                                    title: translation.titles.descartarAlteracoes,
                                    messages: translation.messages.descatarAlteracoesCriacaoEntidade,
                                    titleCancel: translation.fields.descartar,
                                    titleSuccess: translation.fields.continuar,
                                    onCancel: () => checkPreviousRouteWeb(NavigationRouter.centrosDeTrabalhosModule.path),
                                  );
                                },
                              );
                            } else {
                              checkPreviousRouteWeb(NavigationRouter.centrosDeTrabalhosModule.path);
                            }
                          }),
                      const SizedBox(width: 10),
                      CustomPrimaryButton(
                        title: widget.id != null ? translation.fields.salvar : translation.fields.criar,
                        isEnabled: centroTrabalhoController.isEnabled,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.id == null) {
                              inserirEditarCentroTrabalhoStore.adicionarCentroTrabalho(centroTrabalhoController.centroTrabalho);
                            } else {
                              inserirEditarCentroTrabalhoStore.editarCentroTrabalho(centroTrabalhoController.centroTrabalho);
                            }
                          }
                        },
                      )
                    ],
                  );
                },
              ),
            )
          : null,
    );
  }
}
