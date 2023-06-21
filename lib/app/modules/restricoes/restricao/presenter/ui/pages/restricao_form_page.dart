import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';

import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/mobile/mobile_restricao_form_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/desktop_restricao_form_page.dart';

class RestricaoFormPage extends StatefulWidget {
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
  State<RestricaoFormPage> createState() => _RestricaoFormPageState();
}

class _RestricaoFormPageState extends State<RestricaoFormPage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    widget.restricaoFormController.restricao = RestricaoAggregate.empty();
    widget.restricaoFormController.disponibilidade = null;
    widget.restricaoFormController.indisponibilidade = null;
  }

  @override
  Widget build(BuildContext context) {
    final desktopRestricaoFormPage = DesktopRestricaoFormPage(
      getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
      restricaoFormController: widget.restricaoFormController,
      scaffoldController: widget.scaffoldController,
      connectionStore: widget.connectionStore,
      pageController: pageController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileRestricaoFormPage(
        getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
        restricaoFormController: widget.restricaoFormController,
        scaffoldController: widget.scaffoldController,
        connectionStore: widget.connectionStore,
        pageController: pageController,
      ),
      tabletPage: desktopRestricaoFormPage,
      desktopPage: desktopRestricaoFormPage,
    );
  }
}
