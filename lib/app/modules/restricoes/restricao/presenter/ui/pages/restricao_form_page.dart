// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_core/ana_core.dart';

import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/desktop_restricao_form_page.dart';

class RestricaoFormPage extends StatelessWidget {
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final RestricaoFormController restricaoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const RestricaoFormPage({
    Key? key,
    required this.getGrupoDeRestricaoStore,
    required this.restricaoFormController,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final desktopRestricaoFormPage = DesktopRestricaoFormPage(
      getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
      restricaoFormController: restricaoFormController,
      scaffoldController: scaffoldController,
      connectionStore: connectionStore,
    );

    return AdaptiveRedirectorPage(
      mobilePage: Container(),
      tabletPage: desktopRestricaoFormPage,
      desktopPage: desktopRestricaoFormPage,
    );
  }
}
