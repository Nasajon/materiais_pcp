import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_capacidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_disponibilidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_restricao_dados_gerais_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_indisponibilidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/widgets/steppers/stepper_component.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/widgets/steppers/vertical_stepper_widget.dart';

class DesktopRestricaoFormPage extends StatefulWidget {
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final RestricaoFormController restricaoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const DesktopRestricaoFormPage({
    Key? key,
    required this.getGrupoDeRestricaoStore,
    required this.restricaoFormController,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<DesktopRestricaoFormPage> createState() => _DesktopRestricaoFormStatePage();
}

class _DesktopRestricaoFormStatePage extends State<DesktopRestricaoFormPage> {
  RestricaoFormController get restricaoFormController => widget.restricaoFormController;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;

  final PageController pageController = PageController(initialPage: 0);
  final formKey = GlobalKey<FormState>();

  int page = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.getGrupoDeRestricaoStore.getList();

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

  bool _restricaoIsValid() {
    switch (page + 1) {
      case 1:
        return restricaoFormController.restricao.dadosGeraisIsValid;
      case 2:
        return restricaoFormController.restricao.capacidadeIsValid;
      case 3:
        return restricaoFormController.restricao.disponibilidadeIsValid;
      case 4:
        return restricaoFormController.restricao.indisponibilidadeIsValid;
      default:
        return restricaoFormController.restricao.isValid;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;

    return RxBuilder(builder: (context) {
      if (pageController.positions.isNotEmpty && pageController.page != null) {
        page = pageController.page?.round() ?? 0;
      } else {
        page = pageController.initialPage;
      }

      return CustomScaffold.titleString(
        l10n.titles.criarRestricaoSecundaria,
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
                    isValid: restricaoFormController.restricao.dadosGeraisIsValid,
                  ),
                  StepperComponent(
                    textInfo: l10n.fields.capacidade,
                    isValid: restricaoFormController.restricao.capacidadeIsValid,
                  ),
                  StepperComponent(
                    textInfo: l10n.fields.disponibilidade,
                    isValid: restricaoFormController.restricao.disponibilidadeIsValid,
                  ),
                  StepperComponent(
                    textInfo: l10n.fields.indisponibilidade,
                    isValid: restricaoFormController.restricao.indisponibilidadeIsValid,
                  ),
                ],
              ),
              const SizedBox(width: 40),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    DesktopRestricaoDadosGeraisFormWidget(
                      getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                      restricaoFormController: restricaoFormController,
                    ),
                    DesktopCapacidadeFormWidget(restricaoFormController: restricaoFormController),
                    SingleChildScrollView(
                      child: DesktopDisponibilidadeFormWidget(
                        restricaoFormController: restricaoFormController,
                        formKey: formKey,
                      ),
                    ),
                    SingleChildScrollView(
                      child: DesktopIndisponibilidadeFormWidget(
                        restricaoFormController: restricaoFormController,
                        formKey: formKey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: ContainerNavigationBarWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(
                  title: l10n.fields.voltar,
                  isEnabled: page > 0,
                  onPressed: () {
                    pageController.previousPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                  }),
              const SizedBox(width: 10),
              CustomPrimaryButton(
                title: l10n.fields.continuar,
                isEnabled: _restricaoIsValid(),
                onPressed: () async {
                  if (_restricaoIsValid()) {
                    pageController.nextPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                  }
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
