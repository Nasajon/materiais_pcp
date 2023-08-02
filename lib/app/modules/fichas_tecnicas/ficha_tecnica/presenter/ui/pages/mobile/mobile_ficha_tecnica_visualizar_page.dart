// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/ui/pages/mobile/widgets/mobile_ficha_tecnica_dados_gerais_form_widget.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/ui/pages/mobile/widgets/mobile_material_form_widget.dart';

class MobileFichaTecnicaVisualizarPage extends StatefulWidget {
  final ValueNotifier<int> pageNotifier;
  final InserirEditarFichaTecnicaStore inserirEditarFichaTecnicaStore;
  final FichaTecnicaListStore fichaTecnicaListStore;
  final FichaTecnicaFormController fichaTecnicaFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final ValueNotifier<bool> adaptiveModalNotifier;
  final GlobalKey<FormState> dadosGeraisFormKey;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;

  const MobileFichaTecnicaVisualizarPage({
    Key? key,
    required this.pageNotifier,
    required this.inserirEditarFichaTecnicaStore,
    required this.scaffoldController,
    required this.connectionStore,
    required this.adaptiveModalNotifier,
    required this.dadosGeraisFormKey,
    required this.fichaTecnicaListStore,
    required this.fichaTecnicaFormController,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  State<MobileFichaTecnicaVisualizarPage> createState() => _MobileFichaTecnicaVisualizarPageState();
}

class _MobileFichaTecnicaVisualizarPageState extends State<MobileFichaTecnicaVisualizarPage> {
  late final PageController pageController;

  FichaTecnicaAggregate? get oldFichaTecnica => widget.fichaTecnicaFormController.fichaTecnicaOld;

  @override
  void initState() {
    super.initState();
    widget.fichaTecnicaFormController.initOld();
    pageController = PageController(initialPage: widget.pageNotifier.value);
    verificarPage();
  }

  void verificarPage() {
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
    widget.fichaTecnicaFormController.resetOld();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final l10n = translation;

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

    context.select(() => widget.fichaTecnicaFormController.fichaTecnica);

    return ValueListenableBuilder(
      valueListenable: widget.pageNotifier,
      builder: (context, page, child) {
        return CustomScaffold.titleString(
          '${oldFichaTecnica?.codigo} - ${oldFichaTecnica?.descricao}',
          controller: widget.scaffoldController,
          alignment: Alignment.centerLeft,
          actions: [
            InternetButtonIconWidget(connectionStore: widget.connectionStore),
          ],
          onBackPressed: () => (widget.fichaTecnicaFormController.fichaTecnica != oldFichaTecnica) ? showDialogCancel() : Modular.to.pop(),
          tabStatusButtons: [
            TabStatusButton(
              title: l10n.fields.dadosGerais,
              select: page == 0,
              onTap: () => pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
            ),
            TabStatusButton(
              title: l10n.fields.materiais,
              select: page == 1,
              onTap: () => pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
            ),
          ],
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MobileFichaTecnicaDadosGeraisFormWidget(
                fichaTecnicaFormController: widget.fichaTecnicaFormController,
                formKey: widget.dadosGeraisFormKey,
                produtoListStore: context.read(),
                unidadeListStore: context.read(),
              ),
              MobileMaterialFormWidget(
                fichaTecnicaFormController: widget.fichaTecnicaFormController,
                adaptiveModalNotifier: widget.adaptiveModalNotifier,
                produtoListStore: context.read(),
                unidadeListStore: context.read(),
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

                final fichaTEcnica = triple.state;
                if (triple.isLoading == false && fichaTEcnica != null && fichaTEcnica != oldFichaTecnica) {
                  widget.fichaTecnicaListStore.updateFichaTecnica(fichaTEcnica);
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
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
