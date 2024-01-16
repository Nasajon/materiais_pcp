import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/get_turno_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/recurso_form_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/ui/pages/mobile/recurso_form_mobile_page.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/ui/pages/web/recurso_form_desktop_page.dart';

class RecursoFormPage extends StatefulWidget {
  final String? id;
  final RecursoFormStore recursoFormStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetTurnoDeTrabalhoStore getTurnoDeTrabalhoStore;
  final RecursoController recursoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const RecursoFormPage({
    Key? key,
    this.id,
    required this.recursoFormStore,
    required this.getGrupoDeRecursoStore,
    required this.getCentroDeTrabalhoStore,
    required this.getTurnoDeTrabalhoStore,
    required this.recursoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<RecursoFormPage> createState() => _RecursoFormPageState();
}

class _RecursoFormPageState extends State<RecursoFormPage> {
  final oldRecurso = RxNotifier<Recurso?>(null);
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    widget.recursoController.recurso = Recurso.empty();

    widget.recursoController.isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final id = widget.id;

      if (id != null && widget.recursoFormStore.state?.id != id) {
        widget.recursoController.recurso = await widget.recursoFormStore.pegarRecurso(id);
        oldRecurso.value = widget.recursoController.recurso.copyWith();
      }
      widget.recursoController.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorTheme = themeData.extension<AnaColorTheme>();

    final recursoFormDesktopPage = RecursoFormDesktopPage(
      oldRecurso: oldRecurso,
      recursoFormStore: widget.recursoFormStore,
      getGrupoDeRecursoStore: widget.getGrupoDeRecursoStore,
      getCentroDeTrabalhoStore: widget.getCentroDeTrabalhoStore,
      getTurnoDeTrabalhoStore: widget.getTurnoDeTrabalhoStore,
      recursoController: widget.recursoController,
      connectionStore: widget.connectionStore,
      scaffoldController: widget.scaffoldController,
      formKey: formKey,
    );

    return RxBuilder(
      builder: (context) {
        if (widget.recursoController.isLoading) {
          return Center(child: CircularProgressIndicator(color: colorTheme?.primary));
        }

        return AdaptiveRedirectorPage(
          mobilePage: RecursoFormMobilePage(
            oldRecurso: oldRecurso,
            recursoFormStore: widget.recursoFormStore,
            getGrupoDeRecursoStore: widget.getGrupoDeRecursoStore,
            getCentroDeTrabalhoStore: widget.getCentroDeTrabalhoStore,
            getTurnoDeTrabalhoStore: widget.getTurnoDeTrabalhoStore,
            recursoController: widget.recursoController,
            connectionStore: widget.connectionStore,
            scaffoldController: widget.scaffoldController,
            formKey: formKey,
          ),
          tabletPage: recursoFormDesktopPage,
          desktopPage: recursoFormDesktopPage,
        );
      },
    );
  }
}
