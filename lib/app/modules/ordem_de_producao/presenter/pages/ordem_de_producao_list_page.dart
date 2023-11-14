import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/mobile_ordem_de_producao_list_page.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/desktop_ordem_de_producao_list_page.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/ordem_de_producao_list_store.dart';

class OrdemDeProducaoListPage extends StatelessWidget {
  final OrdemDeProducaoListStore ordemDeProducaoListStore;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const OrdemDeProducaoListPage({
    Key? key,
    required this.ordemDeProducaoListStore,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final desktopOrdemDeProducaoListPage = DesktopOrdemDeProducaoListPage(
      ordemDeProducaoListStore: ordemDeProducaoListStore,
      scaffoldController: scaffoldController,
      connectionStore: connectionStore,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileOrdemDeProducaoListPage(
        ordemDeProducaoListStore: ordemDeProducaoListStore,
        scaffoldController: scaffoldController,
        connectionStore: connectionStore,
      ),
      tabletPage: desktopOrdemDeProducaoListPage,
      desktopPage: desktopOrdemDeProducaoListPage,
    );
  }
}
