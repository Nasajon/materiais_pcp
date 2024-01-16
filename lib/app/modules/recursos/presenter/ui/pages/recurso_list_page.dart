import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/recurso_list_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/ui/pages/mobile/recurso_list_mobile_page.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/ui/pages/web/recurso_list_desktop_page.dart';

class RecursoListPage extends StatelessWidget {
  final RecursoListStore recursoListStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const RecursoListPage({
    Key? key,
    required this.recursoListStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recursoListDesktopPage = RecursoListDesktopPage(
      recursoListStore: recursoListStore,
      connectionStore: connectionStore,
      scaffoldController: scaffoldController,
    );
    return AdaptiveRedirectorPage(
      mobilePage: RecursoListMobilePage(
        recursoListStore: recursoListStore,
        connectionStore: connectionStore,
        scaffoldController: scaffoldController,
      ),
      tabletPage: recursoListDesktopPage,
      desktopPage: recursoListDesktopPage,
    );
  }
}
