import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/grupo_de_restricao_form_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/ui/pages/mobile/grupo_de_restricao_form_mobile_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/ui/pages/web/grupo_de_restricao_form_desktop_page.dart';

class GrupoDeRestricaoFormPage extends StatelessWidget {
  final String? id;
  final GrupoDeRestricaoFormStore grupoDeRestricaoFormStore;
  final GrupoDeRestricaoController grupoDeRestricaoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;

  const GrupoDeRestricaoFormPage({
    Key? key,
    this.id,
    required this.grupoDeRestricaoFormStore,
    required this.grupoDeRestricaoController,
    required this.connectionStore,
    required this.scaffoldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final grupoDeRestricaoFormDesktopPage = GrupoDeRestricaoFormDesktopPage(
      id: id,
      grupoDeRestricaoFormStore: grupoDeRestricaoFormStore,
      connectionStore: connectionStore,
      scaffoldController: scaffoldController,
      grupoDeRestricaoController: grupoDeRestricaoController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: GrupoDeRestricaoFormMobilePage(
        id: id,
        grupoDeRestricaoController: grupoDeRestricaoController,
        grupoDeRestricaoFormStore: grupoDeRestricaoFormStore,
        connectionStore: connectionStore,
        scaffoldController: scaffoldController,
      ),
      tabletPage: grupoDeRestricaoFormDesktopPage,
      desktopPage: grupoDeRestricaoFormDesktopPage,
    );
  }
}
