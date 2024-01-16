import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/stores/grupo_de_recurso_list_store.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/ui/pages/mobile/grupo_de_recurso_list_mobile_page.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/ui/pages/web/grupo_de_recurso_list_desktop_page.dart';

class GrupoDeRecursoListPage extends StatelessWidget {
  final GrupoDeRecursoListStore grupoDeRecursoStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRecursoListPage({
    Key? key,
    required this.grupoDeRecursoStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final grupoDeRecursoListDesktopPage = GrupoDeRecursoListDesktopPage(
      grupoDeRecursoStore: grupoDeRecursoStore,
      connectionStore: connectionStore,
      scaffoldController: scaffoldController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: GrupoDeRecursoListMobilePage(
        grupoDeRecursoStore: grupoDeRecursoStore,
        connectionStore: connectionStore,
        scaffoldController: scaffoldController,
      ),
      tabletPage: grupoDeRecursoListDesktopPage,
      desktopPage: grupoDeRecursoListDesktopPage,
    );
  }
}
