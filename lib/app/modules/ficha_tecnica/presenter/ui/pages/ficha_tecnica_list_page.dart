import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/ficha_tecnica_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/mobile/mobile_ficha_tecnica_list_page.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/web/desktop_ficha_tecnica_list_page.dart';

class FichaTecnicaListPage extends StatelessWidget {
  final FichaTecnicaListStore fichaTecnicaListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const FichaTecnicaListPage({
    Key? key,
    required this.fichaTecnicaListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final desktopTurnoTrabalhoListPage = DesktopFichaTecnicaListPage(
      fichaTecnicaListStore: fichaTecnicaListStore,
      scaffoldController: scaffoldController,
      connectionStore: connectionStore,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileFichaTecnicaListPage(
        fichaTecnicaListStore: fichaTecnicaListStore,
        scaffoldController: scaffoldController,
        connectionStore: connectionStore,
      ),
      tabletPage: desktopTurnoTrabalhoListPage,
      desktopPage: desktopTurnoTrabalhoListPage,
    );
  }
}
