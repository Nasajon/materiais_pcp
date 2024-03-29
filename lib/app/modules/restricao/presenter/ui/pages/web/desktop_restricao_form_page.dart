// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/enums/artigo_enum.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_turno_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/inserir_editar_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/ui/pages/web/widgets/desktop_indisponibilidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/ui/pages/web/widgets/desktop_restricao_dados_gerais_form_widget.dart';

class DesktopRestricaoFormPage extends StatefulWidget {
  final ValueNotifier<int> pageNotifier;
  final GlobalKey<FormState> dadosGeraisFormKey;
  final GlobalKey<FormState> capacidadeFormKey;
  final GlobalKey<FormState> disponibilidadeFormKey;
  final GlobalKey<FormState> indisponibilidadeFormKey;
  final InserirEditarRestricaoStore inserirEditarRestricaoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetTurnoDeTrabalhoStore getTurnoDeTrabalhoStore;
  final RestricaoFormController restricaoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const DesktopRestricaoFormPage({
    Key? key,
    required this.pageNotifier,
    required this.dadosGeraisFormKey,
    required this.capacidadeFormKey,
    required this.disponibilidadeFormKey,
    required this.indisponibilidadeFormKey,
    required this.inserirEditarRestricaoStore,
    required this.getGrupoDeRestricaoStore,
    required this.getCentroDeTrabalhoStore,
    required this.getTurnoDeTrabalhoStore,
    required this.restricaoFormController,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<DesktopRestricaoFormPage> createState() => _DesktopRestricaoFormStatePage();
}

class _DesktopRestricaoFormStatePage extends State<DesktopRestricaoFormPage> {
  ValueNotifier<int> get page => widget.pageNotifier;
  GlobalKey<FormState> get dadosGeraisFormKey => widget.dadosGeraisFormKey;
  GlobalKey<FormState> get capacidadeFormKey => widget.capacidadeFormKey;
  GlobalKey<FormState> get disponibilidadeFormKey => widget.disponibilidadeFormKey;
  GlobalKey<FormState> get indisponibilidadeFormKey => widget.indisponibilidadeFormKey;
  InserirEditarRestricaoStore get inserirEditarRestricaoStore => widget.inserirEditarRestricaoStore;
  RestricaoFormController get restricaoFormController => widget.restricaoFormController;
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

    _restricaoIsValid();
  }

  bool _restricaoIsValid() {
    switch (page.value + 1) {
      case 1:
        return dadosGeraisFormKey.currentState != null &&
            dadosGeraisFormKey.currentState!.validate() &&
            restricaoFormController.restricao.dadosGeraisIsValid;
      case 2:
        return (indisponibilidadeFormKey.currentState != null && indisponibilidadeFormKey.currentState!.validate()) ||
            restricaoFormController.restricao.indisponibilidadeIsValid;
      default:
        return restricaoFormController.restricao.isValid;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    // context.select(() => [restricaoFormController.restricao, restricaoFormController.indisponibilidade]);

    return CustomScaffold.titleString(
      translation.titles.criarRestricaoSecundaria,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      onClosePressed: () => checkPreviousRouteWeb(NavigationRouter.restricoesModule.path),
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: page,
              builder: (context, value, child) {
                return VerticalStepperWidget(
                  pageController: pageController,
                  isStepperClickable: true,
                  steppers: [
                    StepperComponent(
                      textInfo: translation.fields.dadosGerais,
                      isValid: restricaoFormController.restricao.dadosGeraisIsValid,
                    ),
                    StepperComponent(
                      textInfo: translation.fields.indisponibilidade,
                      isValid: restricaoFormController.restricao.indisponibilidadeIsValid,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(width: 40),
            Container(
              constraints: const BoxConstraints(maxWidth: 670),
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DesktopRestricaoDadosGeraisFormWidget(
                    getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                    getCentroDeTrabalhoStore: widget.getCentroDeTrabalhoStore,
                    restricaoFormController: restricaoFormController,
                    getTurnoDeTrabalhoStore: widget.getTurnoDeTrabalhoStore,
                    formKey: dadosGeraisFormKey,
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
      bottomNavigationBar: TripleBuilder<InserirEditarRestricaoStore, RestricaoAggregate?>(
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

          final restricao = triple.state;
          if (!triple.isLoading &&
              restricao != null &&
              restricao != RestricaoAggregate.empty() &&
              widget.restricaoFormController.restricao != RestricaoAggregate.empty()) {
            checkPreviousRouteWeb(NavigationRouter.restricoesModule.path);
            NotificationSnackBar.showSnackBar(
              themeData: themeData,
              translation.messages.criouUmaEntidadeComSucesso(translation.fields.restricao, artigo: ArtigoEnum.artigoFeminino),
            );
          }

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
                        print(restricaoFormController.restricao != RestricaoAggregate.empty());
                        if (restricaoFormController.restricao != RestricaoAggregate.empty()) {
                          Asuka.showDialog(
                            barrierColor: Colors.black38,
                            builder: (context) {
                              return ConfirmationModalWidget(
                                title: translation.titles.descartarAlteracoes,
                                messages: translation.messages.descatarAlteracoesCriacaoEntidade,
                                titleCancel: translation.fields.descartar,
                                titleSuccess: translation.fields.continuar,
                                onCancel: () => checkPreviousRouteWeb(NavigationRouter.restricoesModule.path),
                              );
                            },
                          );
                        } else {
                          checkPreviousRouteWeb(NavigationRouter.restricoesModule.path);
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
                        if (page + 1 < 2 && _restricaoIsValid()) {
                          pageController.nextPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                        } else if (_restricaoIsValid() && restricaoFormController.restricao.isValid) {
                          inserirEditarRestricaoStore.adicionarRestricao(restricaoFormController.restricao);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
