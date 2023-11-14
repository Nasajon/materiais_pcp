// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/ficha_tecnica_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/get_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/inserir_editar_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/unidades_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/ui/pages/mobile/mobile_ficha_tecnica_visualizar_page.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/ui/pages/web/desktop_ficha_tecnica_visualizar_page.dart';

class FichaTecnicaVisualizarPage extends StatefulWidget {
  final String fichaTecnicaId;
  final InserirEditarFichaTecnicaStore inserirEditarFichaTecnicaStore;
  final FichaTecnicaListStore fichaTecnicaListStore;
  final GetFichaTecnicaPorIdStore getFichaTecnicaPorIdStore;
  final FichaTecnicaFormController fichaTecnicaFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final ProdutoListStore produtoListStore;
  final UnidadeListStore unidadeListStore;

  const FichaTecnicaVisualizarPage({
    Key? key,
    required this.fichaTecnicaId,
    required this.fichaTecnicaListStore,
    required this.scaffoldController,
    required this.connectionStore,
    required this.inserirEditarFichaTecnicaStore,
    required this.getFichaTecnicaPorIdStore,
    required this.fichaTecnicaFormController,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  State<FichaTecnicaVisualizarPage> createState() => _FichaTecnicaVisualizarPageState();
}

class _FichaTecnicaVisualizarPageState extends State<FichaTecnicaVisualizarPage> {
  final pageNotifier = ValueNotifier(0);
  late final Disposer getFichaTecnicaDisposer;
  final dadosGeraisFormKey = GlobalKey<FormState>();
  final horariosFormKey = GlobalKey<FormState>();
  final adaptiveModalNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    widget.fichaTecnicaFormController.fichaTecnica = FichaTecnicaAggregate.empty();

    widget.getFichaTecnicaPorIdStore.getFichaTecnicaPorId(widget.fichaTecnicaId);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<GetFichaTecnicaPorIdStore, FichaTecnicaAggregate?>(
      store: widget.getFichaTecnicaPorIdStore,
      onLoading: (context) => const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(),
        ),
      ),
      onState: (context, state) {
        if (state != null) {
          widget.fichaTecnicaFormController.fichaTecnica = state.copyWith();
        } else {
          Modular.to.pop();
        }
        widget.fichaTecnicaFormController.resetOld();

        final desktopFichaTecnicaVisualizar = DesktopFichaTecnicaVisualizarPage(
          pageNotifier: pageNotifier,
          inserirEditarFichaTecnicaStore: widget.inserirEditarFichaTecnicaStore,
          fichaTecnicaListStore: widget.fichaTecnicaListStore,
          fichaTecnicaFormController: widget.fichaTecnicaFormController,
          scaffoldController: widget.scaffoldController,
          connectionStore: widget.connectionStore,
          dadosGeraisFormKey: dadosGeraisFormKey,
          materiaisFormKey: horariosFormKey,
          produtoListStore: widget.produtoListStore,
          unidadeListStore: widget.unidadeListStore,
        );

        return ValueListenableBuilder(
          valueListenable: adaptiveModalNotifier,
          builder: (context, value, child) {
            return AdaptiveRedirectorPage(
              mobilePage: MobileFichaTecnicaVisualizarPage(
                pageNotifier: pageNotifier,
                inserirEditarFichaTecnicaStore: widget.inserirEditarFichaTecnicaStore,
                fichaTecnicaListStore: widget.fichaTecnicaListStore,
                fichaTecnicaFormController: widget.fichaTecnicaFormController,
                produtoListStore: widget.produtoListStore,
                unidadeListStore: widget.unidadeListStore,
                scaffoldController: widget.scaffoldController,
                connectionStore: widget.connectionStore,
                adaptiveModalNotifier: adaptiveModalNotifier,
                dadosGeraisFormKey: dadosGeraisFormKey,
              ),
              tabletPage: desktopFichaTecnicaVisualizar,
              desktopPage: desktopFichaTecnicaVisualizar,
            );
          },
        );
      },
    );
  }
}
