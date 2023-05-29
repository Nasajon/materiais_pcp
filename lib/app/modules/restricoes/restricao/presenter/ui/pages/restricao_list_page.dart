import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/mobile/mobile_restricao_list_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/desktop_restricao_list_page.dart';

class RestricaoListPage extends StatelessWidget {
  final RestricaoListStore restricaoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const RestricaoListPage({
    Key? key,
    required this.restricaoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final desktopRestricaoListPage = DesktopRestricaoListPage(
      restricaoListStore: restricaoListStore,
      scaffoldController: scaffoldController,
      connectionStore: connectionStore,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileRestricaoListPage(
        restricaoListStore: restricaoListStore,
        scaffoldController: scaffoldController,
        connectionStore: connectionStore,
      ),
      desktopPage: desktopRestricaoListPage,
    );
  }
}
