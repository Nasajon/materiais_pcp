// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/stores/grupo_de_restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/ui/pages/mobile/grupo_de_restricao_list_mobile_page.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/ui/pages/web/grupo_de_restricao_list_desktop_page.dart';

class GrupoDeRestricaoListPage extends StatelessWidget {
  final GrupoDeRestricaoListStore grupoDeRestricaoStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRestricaoListPage({
    Key? key,
    required this.grupoDeRestricaoStore,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final grupoDeRestricaoListDesktopPage = GrupoDeRestricaoListDesktopPage(
      grupoDeRestricaoStore: grupoDeRestricaoStore,
      connectionStore: connectionStore,
      scaffoldController: scaffoldController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: GrupoDeRestricaoListMobilePage(
        grupoDeRestricaoStore: grupoDeRestricaoStore,
        connectionStore: connectionStore,
        scaffoldController: scaffoldController,
      ),
      tabletPage: grupoDeRestricaoListDesktopPage,
      desktopPage: grupoDeRestricaoListDesktopPage,
    );
  }
}
