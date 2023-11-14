import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/ficha_tecnica_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/inserir_editar_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/unidades_list_store.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/ui/pages/mobile/mobile_ficha_tecnica_form_page.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/ui/pages/web/desktop_ficha_tecnica_form_page.dart';

class FichaTecnicaFormPage extends StatefulWidget {
  final FichaTecnicaListStore fichaTecnicaListStore;
  final InserirEditarFichaTecnicaStore inserirEditarFichaTecnicaStore;
  final FichaTecnicaFormController fichaTecnicaFormController;
  final ProdutoListStore produtoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final UnidadeListStore unidadeListStore;

  const FichaTecnicaFormPage({
    Key? key,
    required this.inserirEditarFichaTecnicaStore,
    required this.fichaTecnicaListStore,
    required this.fichaTecnicaFormController,
    required this.scaffoldController,
    required this.connectionStore,
    required this.produtoListStore,
    required this.unidadeListStore,
  }) : super(key: key);

  @override
  State<FichaTecnicaFormPage> createState() => _FichaTecnicaFormPageState();
}

class _FichaTecnicaFormPageState extends State<FichaTecnicaFormPage> {
  final pageNotifier = ValueNotifier(0);
  final dadosGeraisFormKey = GlobalKey<FormState>();
  final horariosFormKey = GlobalKey<FormState>();
  final adaptiveModalNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    widget.fichaTecnicaFormController.fichaTecnica = FichaTecnicaAggregate.empty();
    widget.fichaTecnicaFormController.material = null;
  }

  @override
  Widget build(BuildContext context) {
    final desktopTurnoTrabalhoFormPage = DesktopFichaTecnicaFormPage(
      pageNotifier: pageNotifier,
      produtoListStore: widget.produtoListStore,
      unidadeListStore: widget.unidadeListStore,
      dadosGeraisFormKey: dadosGeraisFormKey,
      horariosFormKey: horariosFormKey,
      inserirEditarFichaTecnicaStore: widget.inserirEditarFichaTecnicaStore,
      fichaTecnicaListStore: widget.fichaTecnicaListStore,
      fichaTecnicaFormController: widget.fichaTecnicaFormController,
      scaffoldController: widget.scaffoldController,
      connectionStore: widget.connectionStore,
    );

    return ValueListenableBuilder(
        valueListenable: adaptiveModalNotifier,
        builder: (context, value, child) {
          return AdaptiveRedirectorPage(
            mobilePage: MobileFichaTecnicaFormPage(
              pageNotifier: pageNotifier,
              dadosGeraisFormKey: dadosGeraisFormKey,
              inserirEditarFichaTecnicaStore: widget.inserirEditarFichaTecnicaStore,
              fichaTecnicaFormController: widget.fichaTecnicaFormController,
              fichaTecnicaListStore: widget.fichaTecnicaListStore,
              produtoListStore: widget.produtoListStore,
              unidadeListStore: widget.unidadeListStore,
              scaffoldController: widget.scaffoldController,
              connectionStore: widget.connectionStore,
              adaptiveModalNotifier: adaptiveModalNotifier,
            ),
            tabletPage: desktopTurnoTrabalhoFormPage,
            desktopPage: desktopTurnoTrabalhoFormPage,
          );
        });
  }
}
