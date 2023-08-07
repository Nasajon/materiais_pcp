import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/artigos_enum.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/ficha_tecnica_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/inserir_editar_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/unidades_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/ui/pages/web/widgets/desktop_materiais_form_widget.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/ui/pages/web/widgets/desktop_ficha_tecnica_dados_gerais_form_widget.dart';

class DesktopFichaTecnicaVisualizarPage extends StatefulWidget {
  final ValueNotifier<int> pageNotifier;
  final InserirEditarFichaTecnicaStore inserirEditarFichaTecnicaStore;
  final FichaTecnicaListStore fichaTecnicaListStore;
  final FichaTecnicaFormController fichaTecnicaFormController;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final GlobalKey<FormState> dadosGeraisFormKey;
  final GlobalKey<FormState> materiaisFormKey;
  late FichaTecnicaAggregate oldFichaTecnica;
  DesktopFichaTecnicaVisualizarPage({
    Key? key,
    required this.pageNotifier,
    required this.scaffoldController,
    required this.connectionStore,
    required this.dadosGeraisFormKey,
    required this.materiaisFormKey,
    required this.inserirEditarFichaTecnicaStore,
    required this.fichaTecnicaListStore,
    required this.fichaTecnicaFormController,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  State<DesktopFichaTecnicaVisualizarPage> createState() => _DesktopFichaTecnicaVisualizarPageState();
}

class _DesktopFichaTecnicaVisualizarPageState extends State<DesktopFichaTecnicaVisualizarPage> {
  late final PageController pageController;
  FichaTecnicaAggregate? get oldFichaTecnica => widget.fichaTecnicaFormController.fichaTecnicaOld;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: widget.pageNotifier.value);

    widget.fichaTecnicaFormController.initOld();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.addListener(() {
        if (pageController.positions.isNotEmpty && pageController.page != null) {
          widget.pageNotifier.value = (pageController.page?.round() ?? 0);
        } else {
          widget.pageNotifier.value = pageController.initialPage;
        }
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final l10n = translation;

    context.select(() => [widget.fichaTecnicaFormController.fichaTecnica]);

    void showDialogCancel() {
      Asuka.showDialog(
        barrierColor: Colors.black38,
        builder: (context) {
          return ConfirmationModalWidget(
            title: l10n.titles.descartarAlteracoes,
            messages: l10n.messages.descatarAlteracoesEdicaoEntidade,
            titleCancel: l10n.fields.descartar,
            titleSuccess: l10n.fields.continuar,
            onCancel: () => Modular.to.pop(),
          );
        },
      );
    }

    return ValueListenableBuilder(
        valueListenable: widget.pageNotifier,
        builder: (context, page, child) {
          return CustomScaffold.titleString(
            '${oldFichaTecnica?.codigo.value} - ${oldFichaTecnica?.descricao.value}',
            controller: widget.scaffoldController,
            alignment: Alignment.centerLeft,
            actions: [
              InternetButtonIconWidget(connectionStore: widget.connectionStore),
            ],
            onBackPressed: () =>
                (widget.fichaTecnicaFormController.fichaTecnica != oldFichaTecnica) ? showDialogCancel() : Modular.to.pop(),
            tabStatusButtons: [
              TabStatusButton(
                title: l10n.fields.dadosGerais,
                select: page == 0,
                onTap: () => pageController.jumpToPage(0),
              ),
              TabStatusButton(
                title: l10n.fields.materiais,
                select: page == 1,
                onTap: () => pageController.jumpToPage(1),
              ),
            ],
            body: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 52, bottom: 20),
                  child: DesktopFichaTecnicaDadosGeraisFormWidget(
                    fichaTecnicaFormController: widget.fichaTecnicaFormController,
                    produtoListStore: context.read(),
                    unidadeListStore: context.read(),
                    formKey: widget.dadosGeraisFormKey,
                  ),
                ),
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1266),
                      padding: const EdgeInsets.all(35),
                      child: DesktopMateriaisFormWidget(
                        fichaTecnicaFormController: widget.fichaTecnicaFormController,
                        produtoListStore: context.read(),
                        unidadeListStore: context.read(),
                        formKey: widget.materiaisFormKey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Visibility(
              visible: oldFichaTecnica != null && oldFichaTecnica != widget.fichaTecnicaFormController.fichaTecnica,
              child: TripleBuilder<InserirEditarFichaTecnicaStore, FichaTecnicaAggregate?>(
                store: widget.inserirEditarFichaTecnicaStore,
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
                  if (triple.isLoading == false && fichaTecnica != null && fichaTecnica != oldFichaTecnica) {
                    widget.fichaTecnicaListStore.updateFichaTecnica(fichaTecnica);
                    widget.fichaTecnicaFormController.updateOld();
                    widget.fichaTecnicaFormController.fichaTecnicaNotifyListeners();

                    NotificationSnackBar.showSnackBar(
                      l10n.messages.editouEntidadeComSucesso(l10n.titles.fichaTecnica, ArtigoEnum.ARTIGO_FEMININO_DEFINIDO),
                      themeData: themeData,
                    );
                  }

                  return ContainerNavigationBarWidget(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(title: l10n.fields.descartar, isEnabled: !triple.isLoading, onPressed: showDialogCancel),
                        const SizedBox(width: 10),
                        CustomPrimaryButton(
                          title: l10n.fields.salvar,
                          isLoading: triple.isLoading,
                          onPressed: () async {
                            widget.inserirEditarFichaTecnicaStore.editarFichaTecnica(widget.fichaTecnicaFormController.fichaTecnica);
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
