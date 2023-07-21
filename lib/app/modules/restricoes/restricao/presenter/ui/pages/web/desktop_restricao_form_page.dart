// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_capacidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_disponibilidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_indisponibilidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_restricao_dados_gerais_form_widget.dart';

class DesktopRestricaoFormPage extends StatefulWidget {
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final RestricaoFormController restricaoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final PageController pageController;

  const DesktopRestricaoFormPage({
    Key? key,
    required this.getGrupoDeRestricaoStore,
    required this.restricaoFormController,
    required this.scaffoldController,
    required this.connectionStore,
    required this.pageController,
  }) : super(key: key);

  @override
  State<DesktopRestricaoFormPage> createState() => _DesktopRestricaoFormStatePage();
}

class _DesktopRestricaoFormStatePage extends State<DesktopRestricaoFormPage> {
  RestricaoFormController get restricaoFormController => widget.restricaoFormController;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  PageController get pageController => widget.pageController;

  final dadosGeraisFormKey = GlobalKey<FormState>();
  final capacidadeFormKey = GlobalKey<FormState>();
  final disponibilidadeFormKey = GlobalKey<FormState>();
  final indisponibilidadeFormKey = GlobalKey<FormState>();

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
        return dadosGeraisFormKey.currentState != null &&
            dadosGeraisFormKey.currentState!.validate() &&
            restricaoFormController.restricao.dadosGeraisIsValid;
      case 2:
        return capacidadeFormKey.currentState != null &&
            capacidadeFormKey.currentState!.validate() &&
            restricaoFormController.restricao.capacidadeIsValid;
      case 3:
        return disponibilidadeFormKey.currentState != null &&
            disponibilidadeFormKey.currentState!.validate() &&
            restricaoFormController.restricao.disponibilidadeIsValid;
      case 4:
        return indisponibilidadeFormKey.currentState != null &&
            indisponibilidadeFormKey.currentState!.validate() &&
            restricaoFormController.restricao.indisponibilidadeIsValid;
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
                      formKey: dadosGeraisFormKey,
                    ),
                    DesktopCapacidadeFormWidget(
                      restricaoFormController: restricaoFormController,
                      formKey: capacidadeFormKey,
                    ),
                    SingleChildScrollView(
                      child: DesktopDisponibilidadeFormWidget(
                        restricaoFormController: restricaoFormController,
                        formKey: disponibilidadeFormKey,
                      ),
                    ),
                    SingleChildScrollView(
                      child: DesktopIndisponibilidadeFormWidget(
                        restricaoFormController: restricaoFormController,
                        formKey: indisponibilidadeFormKey,
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
                title: l10n.fields.cancelar,
                onPressed: () {
                  Modular.to.pop();
                },
              ),
              const SizedBox(width: 10),
              CustomOutlinedButton(
                title: l10n.fields.voltar,
                isEnabled: page > 0,
                onPressed: () {
                  pageController.previousPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                },
              ),
              const SizedBox(width: 10),
              CustomPrimaryButton(
                title: l10n.fields.continuar,
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
