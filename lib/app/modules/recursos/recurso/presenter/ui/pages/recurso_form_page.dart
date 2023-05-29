// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/recurso_form_store.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/ui/pages/mobile/recurso_form_mobile_page.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/ui/pages/web/recurso_form_desktop_page.dart';

class RecursoFormPage extends StatelessWidget {
  final String? id;
  final RecursoFormStore recursoFormStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final RecursoController recursoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const RecursoFormPage({
    Key? key,
    this.id,
    required this.recursoFormStore,
    required this.getGrupoDeRecursoStore,
    required this.recursoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recursoFormDesktopPage = RecursoFormDesktopPage(
      id: id,
      recursoFormStore: recursoFormStore,
      getGrupoDeRecursoStore: getGrupoDeRecursoStore,
      recursoController: recursoController,
      connectionStore: connectionStore,
      scaffoldController: scaffoldController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: RecursoFormMobilePage(
        id: id,
        recursoFormStore: recursoFormStore,
        getGrupoDeRecursoStore: getGrupoDeRecursoStore,
        recursoController: recursoController,
        connectionStore: connectionStore,
        scaffoldController: scaffoldController,
      ),
      tabletPage: recursoFormDesktopPage,
      desktopPage: recursoFormDesktopPage,
    );
  }
}
