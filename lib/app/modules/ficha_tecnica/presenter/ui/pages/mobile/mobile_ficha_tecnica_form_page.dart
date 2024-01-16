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
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/mobile/widgets/mobile_ficha_tecnica_dados_gerais_form_widget.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/mobile/widgets/mobile_material_form_widget.dart';

class MobileFichaTecnicaFormPage extends StatefulWidget {
  final ValueNotifier<int> pageNotifier;
  final GlobalKey<FormState> dadosGeraisFormKey;
  final InserirEditarFichaTecnicaStore inserirEditarFichaTecnicaStore;
  final FichaTecnicaListStore fichaTecnicaListStore;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;
  final FichaTecnicaFormController fichaTecnicaFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final ValueNotifier<bool> adaptiveModalNotifier;

  const MobileFichaTecnicaFormPage({
    Key? key,
    required this.pageNotifier,
    required this.dadosGeraisFormKey,
    required this.inserirEditarFichaTecnicaStore,
    required this.fichaTecnicaFormController,
    required this.fichaTecnicaListStore,
    required this.scaffoldController,
    required this.connectionStore,
    required this.adaptiveModalNotifier,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  State<MobileFichaTecnicaFormPage> createState() => _MobileFichaTecnicaFormStatePage();
}

class _MobileFichaTecnicaFormStatePage extends State<MobileFichaTecnicaFormPage> {
  ValueNotifier<int> get page => widget.pageNotifier;
  GlobalKey<FormState> get dadosGeraisFormKey => widget.dadosGeraisFormKey;
  InserirEditarFichaTecnicaStore get inserirEditarFichaTecnicaStore => widget.inserirEditarFichaTecnicaStore;
  FichaTecnicaListStore get fichaTecnicaListStore => widget.fichaTecnicaListStore;
  FichaTecnicaFormController get fichaTecnicaFormController => widget.fichaTecnicaFormController;
  ProdutoListStore get produtoListStore => widget.produtoListStore;
  UnidadeListStore get unidadeListStore => widget.unidadeListStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  ValueNotifier<bool> get adaptiveModalNotifier => widget.adaptiveModalNotifier;
  bool get descartarEdicao => widget.fichaTecnicaFormController.fichaTecnica != FichaTecnicaAggregate.empty();
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

    _fichaTecnicaIsValid();
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

  bool _fichaTecnicaIsValid() {
    switch (page.value + 1) {
      case 1:
        return dadosGeraisFormKey.currentState != null &&
            dadosGeraisFormKey.currentState!.validate() &&
            fichaTecnicaFormController.fichaTecnica.isValid;
      case 2:
        return fichaTecnicaFormController.fichaTecnica.isMateriaisValid;
      default:
        return fichaTecnicaFormController.fichaTecnica.isValid;
    }
  }

  @override
  void dispose() {
    widget.fichaTecnicaFormController.resetOld();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
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
      onClosePressed: showDialogCancel,
      alignment: Alignment.centerLeft,
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
            ),
            const SizedBox(height: 32),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MobileFichaTecnicaDadosGeraisFormWidget(
                    fichaTecnicaFormController: fichaTecnicaFormController,
                    formKey: dadosGeraisFormKey,
                    produtoListStore: produtoListStore,
                    unidadeListStore: unidadeListStore,
                  ),
                  MobileMaterialFormWidget(
                    fichaTecnicaFormController: fichaTecnicaFormController,
                    produtoListStore: produtoListStore,
                    unidadeListStore: unidadeListStore,
                    adaptiveModalNotifier: adaptiveModalNotifier,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TripleBuilder<InserirEditarFichaTecnicaStore, FichaTecnicaAggregate?>(
        store: inserirEditarFichaTecnicaStore,
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

          final fichaTecnica = triple.state;
          if (triple.isLoading == false && fichaTecnica != null) {
            fichaTecnicaListStore.addFichaTecnica(fichaTecnica);
            checkPreviousRouteWeb(NavigationRouter.fichasTecnicasModule.path);
            NotificationSnackBar.showSnackBar(
              l10n.messages.criouAEntidadeComSucesso(l10n.titles.fichaTecnica, artigo: ArtigoEnum.artigoFeminino),
              themeData: themeData,
            );
          }

          return RxBuilder(
            builder: (context) {
              final descartarEdicao = fichaTecnicaFormController.fichaTecnica != FichaTecnicaAggregate.empty();

              return ContainerNavigationBarWidget(
                child: ValueListenableBuilder(
                  valueListenable: page,
                  builder: (context, page, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                          title: descartarEdicao ? l10n.fields.descartar : l10n.fields.cancelar,
                          onPressed: showDialogCancel,
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
                            if (page + 1 < 2 && _fichaTecnicaIsValid()) {
                              pageController.nextPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                            } else if (_fichaTecnicaIsValid() && fichaTecnicaFormController.fichaTecnica.isValid) {
                              inserirEditarFichaTecnicaStore.adicionarFichaTecnica(fichaTecnicaFormController.fichaTecnica);
                            }
                          },
                        )
                      ],
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
