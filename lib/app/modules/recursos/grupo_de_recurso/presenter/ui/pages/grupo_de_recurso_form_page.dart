import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/controllers/grupo_de_recurso_controller.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/stores/grupo_de_recurso_form_store.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/ui/pages/mobile/grupo_de_recurso_form_mobile_page.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/ui/pages/web/grupo_de_recurso_form_desktop_page.dart';

class GrupoDeRecursoFormPage extends StatefulWidget {
  final String? id;
  final GrupoDeRecursoFormStore grupoDeRecursoFormStore;
  final GrupoDeRecursoController grupoDeRecursoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRecursoFormPage({
    Key? key,
    this.id,
    required this.grupoDeRecursoFormStore,
    required this.grupoDeRecursoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  State<GrupoDeRecursoFormPage> createState() => _GrupoDeRecursoFormPageState();
}

class _GrupoDeRecursoFormPageState extends State<GrupoDeRecursoFormPage> {
  final oldGrupoDeRecurso = ValueNotifier<GrupoDeRecurso?>(null);

  @override
  void initState() {
    super.initState();

    widget.grupoDeRecursoController.grupoDeRecurso = GrupoDeRecurso.empty();

    widget.grupoDeRecursoController.isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final id = widget.id;
      if (id != null && widget.grupoDeRecursoController.grupoDeRecurso.id != id) {
        widget.grupoDeRecursoController.grupoDeRecurso = await widget.grupoDeRecursoFormStore.pegarGrupoDeRecurso(id);
        oldGrupoDeRecurso.value = widget.grupoDeRecursoController.grupoDeRecurso.copyWith();
      }
      widget.grupoDeRecursoController.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        if (widget.grupoDeRecursoController.isLoading) {
          return const Center(child: CircularProgressIndicator(color: AnaColors.darkBlue));
        }

        final grupoDeRecursoFormDesktopPage = GrupoDeRecursoFormDesktopPage(
          oldGrupoDeRecurso: oldGrupoDeRecurso,
          grupoDeRecursoFormStore: widget.grupoDeRecursoFormStore,
          connectionStore: widget.connectionStore,
          scaffoldController: widget.scaffoldController,
          grupoDeRecursoController: widget.grupoDeRecursoController,
        );

        return AdaptiveRedirectorPage(
          mobilePage: GrupoDeRecursoFormMobilePage(
            oldGrupoDeRecurso: oldGrupoDeRecurso,
            grupoDeRecursoFormStore: widget.grupoDeRecursoFormStore,
            connectionStore: widget.connectionStore,
            scaffoldController: widget.scaffoldController,
            grupoDeRecursoController: widget.grupoDeRecursoController,
          ),
          tabletPage: grupoDeRecursoFormDesktopPage,
          desktopPage: grupoDeRecursoFormDesktopPage,
        );
      },
    );
  }
}
