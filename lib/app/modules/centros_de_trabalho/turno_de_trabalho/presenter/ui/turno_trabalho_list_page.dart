import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/mobile/mobile_turno_trabalho_list_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/desktop_turno_trabalho_list_page.dart';

class TurnoTrabalhoListPage extends StatelessWidget {
  final TurnoTrabalhoListStore turnoTrabalhoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const TurnoTrabalhoListPage({
    Key? key,
    required this.turnoTrabalhoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final desktopTurnoTrabalhoListPage = DesktopTurnoTrabalhoListPage(
      turnoTrabalhoListStore: turnoTrabalhoListStore,
      scaffoldController: scaffoldController,
      connectionStore: connectionStore,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileTurnoTrabalhoListPage(
        turnoTrabalhoListStore: turnoTrabalhoListStore,
        scaffoldController: scaffoldController,
        connectionStore: connectionStore,
      ),
      tabletPage: desktopTurnoTrabalhoListPage,
      desktopPage: desktopTurnoTrabalhoListPage,
    );
  }
}
