// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/inserir_editar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/mobile/widgets/mobile_horario_form_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/mobile/widgets/mobile_turno_trabalho_dados_gerais_form_widget.dart';

class MobileTurnoTrabalhoFormPage extends StatefulWidget {
  final ValueNotifier<int> pageNotifier;
  final GlobalKey<FormState> dadosGeraisFormKey;
  final InserirEditarTurnoTrabalhoStore inserirEditarTurnoTrabalhoStore;
  final TurnoTrabalhoListStore turnoTrabalhoListStore;
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final ValueNotifier<bool> adaptiveModalNotifier;

  const MobileTurnoTrabalhoFormPage({
    Key? key,
    required this.pageNotifier,
    required this.dadosGeraisFormKey,
    required this.inserirEditarTurnoTrabalhoStore,
    required this.turnoTrabalhoListStore,
    required this.turnoTrabalhoFormController,
    required this.scaffoldController,
    required this.connectionStore,
    required this.adaptiveModalNotifier,
  }) : super(key: key);

  @override
  State<MobileTurnoTrabalhoFormPage> createState() => _MobileTurnoTrabalhoFormStatePage();
}

class _MobileTurnoTrabalhoFormStatePage extends State<MobileTurnoTrabalhoFormPage> {
  ValueNotifier<int> get page => widget.pageNotifier;
  GlobalKey<FormState> get dadosGeraisFormKey => widget.dadosGeraisFormKey;
  InserirEditarTurnoTrabalhoStore get inserirEditarTurnoTrabalhoStore => widget.inserirEditarTurnoTrabalhoStore;
  TurnoTrabalhoListStore get turnoTrabalhoListStore => widget.turnoTrabalhoListStore;
  TurnoTrabalhoFormController get turnoTrabalhoFormController => widget.turnoTrabalhoFormController;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  ValueNotifier<bool> get adaptiveModalNotifier => widget.adaptiveModalNotifier;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: page.value);
    verificarPage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _turnoTrabalhoIsValid();
  }

  void verificarPage() {
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

  bool _turnoTrabalhoIsValid() {
    switch (page.value + 1) {
      case 1:
        return dadosGeraisFormKey.currentState != null &&
            dadosGeraisFormKey.currentState!.validate() &&
            turnoTrabalhoFormController.turnoTrabalho.isDadosGeraisValid;
      case 2:
        return turnoTrabalhoFormController.turnoTrabalho.isHorarioValid;
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
    final l10n = context.l10nLocalization;

    return CustomScaffold.titleString(
      l10n.titles.criarTurnoDeTrabalho,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      onIconTap: () => Modular.to.pop(),
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ValueListenableBuilder(
                  valueListenable: page,
                  builder: (_, __, ___) {
                    return HorizontalStepperWidget(
                      scrollController: ScrollController(),
                      pageController: pageController,
                      isStepperClickable: true,
                      steppers: [
                        StepperComponent(
                          textInfo: l10n.fields.dadosGerais,
                          isValid: turnoTrabalhoFormController.turnoTrabalho.isDadosGeraisValid,
                        ),
                        StepperComponent(
                          textInfo: l10n.fields.horarios,
                          isValid: turnoTrabalhoFormController.turnoTrabalho.isHorarioValid,
                        ),
                      ],
                    );
                  }),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MobileTurnoTrabalhoDadosGeraisFormWidget(
                    turnoTrabalhoFormController: turnoTrabalhoFormController,
                    formKey: dadosGeraisFormKey,
                  ),
                  MobileHorarioFormWidget(
                    turnoTrabalhoFormController: turnoTrabalhoFormController,
                    adaptiveModalNotifier: adaptiveModalNotifier,
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
          if (triple.isLoading == false && turnoTrabalho != null) {
            turnoTrabalhoListStore.addTurnoTrabalho(turnoTrabalho);
            Modular.to.pop();
            NotificationSnackBar.showSnackBar(
              l10n.messages.criouUmEntidadeComSucesso(l10n.titles.turnosDeTrabalho),
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
                            title: descartarEdicao ? l10n.fields.descartar : l10n.fields.cancelar,
                            onPressed: () {
                              if (descartarEdicao) {
                                Asuka.showDialog(
                                  barrierColor: Colors.black38,
                                  builder: (context) {
                                    return ConfirmationModalWidget(
                                      title: l10n.titles.descartarAlteracoes,
                                      messages: l10n.messages.descatarAlteracoesCriacaoEntidade,
                                      titleCancel: l10n.fields.descartar,
                                      titleSuccess: l10n.fields.continuar,
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
                              title: l10n.fields.voltar,
                              isEnabled: !triple.isLoading,
                              onPressed: () {
                                pageController.previousPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          CustomPrimaryButton(
                            title: page + 1 < 2 ? l10n.fields.continuar : l10n.fields.criar,
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
