import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/inserir_editar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/widgets/desktop_horario_form_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/widgets/desktop_turno_trabalho_dados_gerais_form_widget.dart';

class DesktopTurnoTrabalhoFormPage extends StatefulWidget {
  final ValueNotifier<int> pageNotifier;
  final GlobalKey<FormState> dadosGeraisFormKey;
  final GlobalKey<FormState> horariosFormKey;
  final InserirEditarTurnoTrabalhoStore inserirEditarTurnoTrabalhoStore;
  final TurnoTrabalhoListStore turnoTrabalhoListStore;
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const DesktopTurnoTrabalhoFormPage({
    Key? key,
    required this.pageNotifier,
    required this.dadosGeraisFormKey,
    required this.horariosFormKey,
    required this.inserirEditarTurnoTrabalhoStore,
    required this.turnoTrabalhoListStore,
    required this.turnoTrabalhoFormController,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<DesktopTurnoTrabalhoFormPage> createState() => _DesktopTurnoTrabalhoFormStatePage();
}

class _DesktopTurnoTrabalhoFormStatePage extends State<DesktopTurnoTrabalhoFormPage> {
  ValueNotifier<int> get page => widget.pageNotifier;
  GlobalKey<FormState> get dadosGeraisFormKey => widget.dadosGeraisFormKey;
  GlobalKey<FormState> get horariosFormKey => widget.horariosFormKey;
  InserirEditarTurnoTrabalhoStore get inserirEditarTurnoTrabalhoStore => widget.inserirEditarTurnoTrabalhoStore;
  TurnoTrabalhoListStore get turnoTrabalhoListStore => widget.turnoTrabalhoListStore;
  TurnoTrabalhoFormController get turnoTrabalhoFormController => widget.turnoTrabalhoFormController;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: page.value);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.addListener(() {
        if (pageController.positions.isNotEmpty && pageController.page != null) {
          page.value = (pageController.page?.round() ?? 0);
        } else {
          page.value = pageController.initialPage;
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _turnoTrabalhoIsValid();
  }

  bool _turnoTrabalhoIsValid() {
    switch (page.value + 1) {
      case 1:
        return dadosGeraisFormKey.currentState != null &&
            dadosGeraisFormKey.currentState!.validate() &&
            turnoTrabalhoFormController.turnoTrabalho.isDadosGeraisValid;
      case 2:
        return (horariosFormKey.currentState != null && horariosFormKey.currentState!.validate()) ||
            (turnoTrabalhoFormController.horario == null && turnoTrabalhoFormController.turnoTrabalho.isHorarioValid);
      default:
        return turnoTrabalhoFormController.turnoTrabalho.isValid;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return CustomScaffold.titleString(
      translation.titles.criarTurnoDeTrabalho,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: page,
                builder: (_, __, ___) {
                  return VerticalStepperWidget(
                    pageController: pageController,
                    isStepperClickable: true,
                    steppers: [
                      StepperComponent(
                        textInfo: translation.fields.dadosGerais,
                        isValid: turnoTrabalhoFormController.turnoTrabalho.isDadosGeraisValid,
                      ),
                      StepperComponent(
                        textInfo: translation.fields.horarios,
                        isValid: turnoTrabalhoFormController.turnoTrabalho.isHorarioValid,
                      ),
                    ],
                  );
                }),
            const SizedBox(width: 40),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DesktopTurnoTrabalhoDadosGeraisFormWidget(
                    turnoTrabalhoFormController: turnoTrabalhoFormController,
                    formKey: dadosGeraisFormKey,
                  ),
                  SingleChildScrollView(
                    child: DesktopHorarioFormWidget(
                      turnoTrabalhoFormController: turnoTrabalhoFormController,
                      formKey: horariosFormKey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TripleBuilder<InserirEditarTurnoTrabalhoStore, TurnoTrabalhoAggregate?>(
        store: inserirEditarTurnoTrabalhoStore,
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

          final turnoTrabalho = triple.state;
          if (!triple.isLoading && turnoTrabalho != null) {
            turnoTrabalhoListStore.addTurnoTrabalho(turnoTrabalho);
            Modular.to.pop();
            NotificationSnackBar.showSnackBar(
              translation.messages.criouAEntidadeComSucesso(translation.titles.turnosDeTrabalho),
              themeData: themeData,
            );
          }

          return RxBuilder(
            builder: (context) {
              final descartarEdicao = turnoTrabalhoFormController.turnoTrabalho != TurnoTrabalhoAggregate.empty();

              return ContainerNavigationBarWidget(
                child: ValueListenableBuilder(
                    valueListenable: page,
                    builder: (context, page, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                            title: translation.fields.cancelar,
                            isEnabled: !triple.isLoading,
                            onPressed: () {
                              if (descartarEdicao) {
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
                          Visibility(
                            visible: page > 0,
                            child: CustomOutlinedButton(
                              title: translation.fields.voltar,
                              isEnabled: !triple.isLoading,
                              onPressed: () {
                                pageController.previousPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          CustomPrimaryButton(
                            title: page + 1 < 2 ? translation.fields.continuar : translation.fields.criar,
                            isEnabled: !triple.isLoading,
                            isLoading: triple.isLoading,
                            onPressed: () async {
                              if (page + 1 < 2 && _turnoTrabalhoIsValid()) {
                                pageController.nextPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                              } else if (_turnoTrabalhoIsValid() && turnoTrabalhoFormController.turnoTrabalho.isValid) {
                                inserirEditarTurnoTrabalhoStore.adicionarTurnoTrabalho(turnoTrabalhoFormController.turnoTrabalho);
                              }
                            },
                          )
                        ],
                      );
                    }),
              );
            },
          );
        },
      ),
    );
  }
}
