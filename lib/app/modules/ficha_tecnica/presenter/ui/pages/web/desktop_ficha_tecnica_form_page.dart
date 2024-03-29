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
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/ficha_tecnica_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/inserir_editar_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/unidades_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/web/widgets/desktop_materiais_form_widget.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/web/widgets/desktop_ficha_tecnica_dados_gerais_form_widget.dart';

class DesktopFichaTecnicaFormPage extends StatefulWidget {
  final ValueNotifier<int> pageNotifier;
  final GlobalKey<FormState> dadosGeraisFormKey;
  final GlobalKey<FormState> horariosFormKey;
  final InserirEditarFichaTecnicaStore inserirEditarFichaTecnicaStore;
  final FichaTecnicaListStore fichaTecnicaListStore;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;
  final FichaTecnicaFormController fichaTecnicaFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const DesktopFichaTecnicaFormPage({
    Key? key,
    required this.pageNotifier,
    required this.dadosGeraisFormKey,
    required this.horariosFormKey,
    required this.inserirEditarFichaTecnicaStore,
    required this.fichaTecnicaListStore,
    required this.fichaTecnicaFormController,
    required this.scaffoldController,
    required this.connectionStore,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  State<DesktopFichaTecnicaFormPage> createState() => _DesktopFichaTecnicaFormStatePage();
}

class _DesktopFichaTecnicaFormStatePage extends State<DesktopFichaTecnicaFormPage> {
  ValueNotifier<int> get pageNotifier => widget.pageNotifier;
  GlobalKey<FormState> get dadosGeraisFormKey => widget.dadosGeraisFormKey;
  GlobalKey<FormState> get horariosFormKey => widget.horariosFormKey;
  ProdutoListStore get produtoListStore => widget.produtoListStore;
  UnidadeListStore get unidadeListStore => widget.unidadeListStore;
  InserirEditarFichaTecnicaStore get inserirEditarFichaTecnicaStore => widget.inserirEditarFichaTecnicaStore;
  FichaTecnicaListStore get fichaTecnicaListStore => widget.fichaTecnicaListStore;
  FichaTecnicaFormController get fichaTecnicaFormController => widget.fichaTecnicaFormController;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  bool get descartarEdicao => widget.fichaTecnicaFormController.fichaTecnica != FichaTecnicaAggregate.empty();
  late final PageController pageController;

  late final Disposer inserirEditarFichaTecnicaDisposer;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageNotifier.value);

    inserirEditarFichaTecnicaDisposer = inserirEditarFichaTecnicaStore.observer(
      onLoading: (value) => setState(() {}),
      onError: (error) {
        if (error is Failure) {
          Asuka.showDialog(
            barrierColor: Colors.black38,
            builder: (context) {
              return ErrorModal(errorMessage: error.errorMessage ?? '');
            },
          );
        }
        setState(() {});
      },
      onState: (state) {
        if (state != null) {
          fichaTecnicaListStore.addFichaTecnica(state);
          checkPreviousRouteWeb(NavigationRouter.fichasTecnicasModule.path);
          NotificationSnackBar.showSnackBar(
            translation.messages.editouAEntidadeComSucesso(translation.fields.fichaTecnica, artigo: ArtigoEnum.artigoFeminino),
            themeData: Theme.of(context),
          );
        }
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.addListener(() {
        if (pageController.positions.isNotEmpty && pageController.page != null) {
          pageNotifier.value = (pageController.page?.round() ?? 0);
        } else {
          pageNotifier.value = pageController.initialPage;
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _fichaTecnicaIsValid();
  }

  bool _fichaTecnicaIsValid() {
    switch (pageNotifier.value + 1) {
      case 1:
        return dadosGeraisFormKey.currentState != null &&
            dadosGeraisFormKey.currentState!.validate() &&
            fichaTecnicaFormController.fichaTecnica.isValid;
      case 2:
        return (horariosFormKey.currentState != null && horariosFormKey.currentState!.validate()) ||
            (fichaTecnicaFormController.material == null);
      default:
        return fichaTecnicaFormController.fichaTecnica.isValid;
    }
  }

  @override
  void dispose() {
    widget.fichaTecnicaFormController.resetOld();
    pageController.dispose();
    inserirEditarFichaTecnicaDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = translation;

    void showDialogCancel() {
      descartarEdicao
          ? Asuka.showDialog(
              barrierColor: Colors.black38,
              builder: (context) {
                return ConfirmationModalWidget(
                  title: l10n.titles.descartarAlteracoes,
                  messages: l10n.messages.descatarAlteracoesCriacaoEntidade,
                  titleCancel: l10n.fields.descartar,
                  titleSuccess: l10n.fields.continuar,
                  onCancel: () => checkPreviousRouteWeb(NavigationRouter.fichasTecnicasModule.path),
                );
              },
            )
          : checkPreviousRouteWeb(NavigationRouter.fichasTecnicasModule.path);
    }

    return CustomScaffold.titleString(
      l10n.titles.criarFichaTecnica,
      controller: scaffoldController,
      alignment: Alignment.centerLeft,
      onClosePressed: showDialogCancel,
      actions: [
        InternetButtonIconWidget(connectionStore: connectionStore),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: pageNotifier,
                builder: (_, page, ___) {
                  return VerticalStepperWidget(
                    pageController: pageController,
                    isStepperClickable: true,
                    steppers: [
                      StepperComponent(
                        textInfo: l10n.fields.dadosGerais,
                        isValid: fichaTecnicaFormController.fichaTecnica.isValid,
                      ),
                      StepperComponent(
                        textInfo: l10n.fields.materiais,
                        isValid: fichaTecnicaFormController.fichaTecnica.isMateriaisValid,
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
                  DesktopFichaTecnicaDadosGeraisFormWidget(
                    produtoListStore: produtoListStore,
                    unidadeListStore: unidadeListStore,
                    fichaTecnicaFormController: fichaTecnicaFormController,
                    formKey: dadosGeraisFormKey,
                  ),
                  SingleChildScrollView(
                    child: DesktopMateriaisFormWidget(
                      fichaTecnicaFormController: fichaTecnicaFormController,
                      formKey: horariosFormKey,
                      produtoListStore: produtoListStore,
                      unidadeListStore: unidadeListStore,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ContainerNavigationBarWidget(
        child: ValueListenableBuilder(
            valueListenable: pageNotifier,
            builder: (context, page, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    title: descartarEdicao ? l10n.fields.descartar : l10n.fields.cancelar,
                    isEnabled: !inserirEditarFichaTecnicaStore.isLoading,
                    onPressed: showDialogCancel,
                  ),
                  const SizedBox(width: 10),
                  Visibility(
                    visible: page > 0,
                    child: CustomOutlinedButton(
                      title: l10n.fields.voltar,
                      isEnabled: !inserirEditarFichaTecnicaStore.isLoading,
                      onPressed: () {
                        pageController.previousPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomPrimaryButton(
                    title: page + 1 < 2 ? l10n.fields.continuar : l10n.fields.criar,
                    isEnabled: !inserirEditarFichaTecnicaStore.isLoading,
                    isLoading: inserirEditarFichaTecnicaStore.isLoading,
                    onPressed: () async {
                      if (page + 1 < 2 && _fichaTecnicaIsValid()) {
                        pageController.nextPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                      } else if (_fichaTecnicaIsValid() && fichaTecnicaFormController.fichaTecnica.isValid) {
                        inserirEditarFichaTecnicaStore.adicionarFichaTecnica(fichaTecnicaFormController.fichaTecnica);
                      }
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}
