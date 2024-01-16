import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/stores/centro_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/ui/pages/mobiles/mobile_centro_trabalho_list_page.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/ui/pages/web/desktop_centro_trabalho_list_page.dart';

class CentroTrabalhoListPage extends StatelessWidget {
  final CentroTrabalhoListStore centroTrabalhoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const CentroTrabalhoListPage({
    Key? key,
    required this.centroTrabalhoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final desktopCentroTrabalhoListPage = DesktopCentroTrabalhoListPage(
      centroTrabalhoListStore: centroTrabalhoListStore,
      scaffoldController: scaffoldController,
      connectionStore: connectionStore,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileCentroTrabalhoListPage(
        centroTrabalhoListStore: centroTrabalhoListStore,
        scaffoldController: scaffoldController,
        connectionStore: connectionStore,
      ),
      tabletPage: desktopCentroTrabalhoListPage,
      desktopPage: desktopCentroTrabalhoListPage,
    );
  }
}
