import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/roteiro_list_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/web/desktop_roteiro_list_page.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/mobile/mobile_roteiro_list_page.dart';

class RoteiroListPage extends StatelessWidget {
  final RoteiroListStore roteiroListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const RoteiroListPage({
    Key? key,
    required this.roteiroListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final desktopRoteiroListPage = DesktopRoteiroListPage(
      roteiroListStore: roteiroListStore,
      scaffoldController: scaffoldController,
      connectionStore: connectionStore,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileRoteiroListPage(
        roteiroListStore: roteiroListStore,
        scaffoldController: scaffoldController,
        connectionStore: connectionStore,
      ),
      tabletPage: desktopRoteiroListPage,
      desktopPage: desktopRoteiroListPage,
    );
  }
}
