// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/controllers/grupo_de_recurso_controller.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/stores/grupo_de_recurso_form_store.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/ui/pages/mobile/grupo_de_recurso_form_mobile_page.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/ui/pages/web/grupo_de_recurso_form_desktop_page.dart';

class GrupoDeRecursoFormPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final grupoDeRecursoFormDesktopPage = GrupoDeRecursoFormDesktopPage(
      id: id,
      grupoDeRecursoFormStore: grupoDeRecursoFormStore,
      connectionStore: connectionStore,
      scaffoldController: scaffoldController,
      grupoDeRecursoController: grupoDeRecursoController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: GrupoDeRecursoFormMobilePage(
        id: id,
        grupoDeRecursoController: grupoDeRecursoController,
        grupoDeRecursoFormStore: grupoDeRecursoFormStore,
        connectionStore: connectionStore,
        scaffoldController: scaffoldController,
      ),
      tabletPage: grupoDeRecursoFormDesktopPage,
      desktopPage: grupoDeRecursoFormDesktopPage,
    );
  }
}
