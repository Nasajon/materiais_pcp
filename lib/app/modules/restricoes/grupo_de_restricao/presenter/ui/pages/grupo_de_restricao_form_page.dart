import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/grupo_de_restricao_form_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/ui/pages/mobile/grupo_de_restricao_form_mobile_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/ui/pages/web/grupo_de_restricao_form_desktop_page.dart';

class GrupoDeRestricaoFormPage extends StatefulWidget {
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
  State<GrupoDeRestricaoFormPage> createState() => _GrupoDeRestricaoFormPageState();
}

class _GrupoDeRestricaoFormPageState extends State<GrupoDeRestricaoFormPage> {
  @override
  void initState() {
    super.initState();

    widget.grupoDeRestricaoController.grupoDeRestricao = GrupoDeRestricaoEntity.empty();
  }

  @override
  Widget build(BuildContext context) {
    final grupoDeRestricaoFormDesktopPage = GrupoDeRestricaoFormDesktopPage(
      id: widget.id,
      grupoDeRestricaoFormStore: widget.grupoDeRestricaoFormStore,
      connectionStore: widget.connectionStore,
      scaffoldController: widget.scaffoldController,
      grupoDeRestricaoController: widget.grupoDeRestricaoController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: GrupoDeRestricaoFormMobilePage(
        id: widget.id,
        grupoDeRestricaoController: widget.grupoDeRestricaoController,
        grupoDeRestricaoFormStore: widget.grupoDeRestricaoFormStore,
        connectionStore: widget.connectionStore,
        scaffoldController: widget.scaffoldController,
      ),
      tabletPage: grupoDeRestricaoFormDesktopPage,
      desktopPage: grupoDeRestricaoFormDesktopPage,
    );
  }
}
