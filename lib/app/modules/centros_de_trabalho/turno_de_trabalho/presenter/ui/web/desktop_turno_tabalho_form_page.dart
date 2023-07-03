import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/inserir_editar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/widgets/desktop_horario_form_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/widgets/desktop_turno_trabalho_dados_gerais_form_widget.dart';

class DesktopTurnoTrabalhoFormPage extends StatefulWidget {
  final InserirEditarTurnoTrabalhoStore inserirEditarTurnoTrabalhoStore;
  final TurnoTrabalhoListStore turnoTrabalhoListStore;
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final PageController pageController;

  const DesktopTurnoTrabalhoFormPage({
    Key? key,
    required this.turnoTrabalhoListStore,
    required this.inserirEditarTurnoTrabalhoStore,
    required this.turnoTrabalhoFormController,
    required this.scaffoldController,
    required this.connectionStore,
    required this.pageController,
  }) : super(key: key);

  @override
  State<DesktopTurnoTrabalhoFormPage> createState() => _DesktopTurnoTrabalhoFormStatePage();
}

class _DesktopTurnoTrabalhoFormStatePage extends State<DesktopTurnoTrabalhoFormPage> {
  InserirEditarTurnoTrabalhoStore get inserirEditarTurnoTrabalhoStore => widget.inserirEditarTurnoTrabalhoStore;
  TurnoTrabalhoListStore get turnoTrabalhoListStore => widget.turnoTrabalhoListStore;
  TurnoTrabalhoFormController get turnoTrabalhoFormController => widget.turnoTrabalhoFormController;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  PageController get pageController => widget.pageController;

  final dadosGeraisFormKey = GlobalKey<FormState>();
  final horariosFormKey = GlobalKey<FormState>();

  int page = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.addListener(() {
        setState(() {
          if (pageController.positions.isNotEmpty && pageController.page != null) {
            page = (pageController.page?.round() ?? 0) + 1;
          } else {
            page = pageController.initialPage + 1;
          }
        });
      });
    });
  }

  bool _turnoTrabalhoIsValid() {
    switch (page + 1) {
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
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;

    return RxBuilder(
      builder: (context) {
        if (pageController.positions.isNotEmpty && pageController.page != null) {
          page = pageController.page?.round() ?? 0;
        } else {
          page = pageController.initialPage;
        }

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalStepperWidget(
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
                ),
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
              final turnoTrabalho = triple.state;

              if (triple.isLoading == false && turnoTrabalho != null) {
                turnoTrabalhoListStore.addTurnoTrabalho(turnoTrabalho);
                Modular.to.pop();
              }

              return ContainerNavigationBarWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      title: l10n.fields.cancelar,
                      isEnabled: !triple.isLoading,
                      onPressed: () {
                        Modular.to.pop();
                      },
                    ),
                    const SizedBox(width: 10),
                    CustomOutlinedButton(
                      title: l10n.fields.voltar,
                      isEnabled: page > 0 && !triple.isLoading,
                      onPressed: () {
                        pageController.previousPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                      },
                    ),
                    const SizedBox(width: 10),
                    CustomPrimaryButton(
                      title: l10n.fields.continuar,
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
                ),
              );
            },
          ),
        );
      },
    );
  }
}