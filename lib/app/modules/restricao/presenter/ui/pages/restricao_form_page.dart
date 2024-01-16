// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_turno_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/inserir_editar_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/ui/pages/mobile/mobile_restricao_form_page.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/ui/pages/web/desktop_restricao_form_page.dart';

class RestricaoFormPage extends StatefulWidget {
  final InserirEditarRestricaoStore inserirEditarRestricaoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetTurnoDeTrabalhoStore getTurnoDeTrabalhoStore;
  final RestricaoFormController restricaoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const RestricaoFormPage({
    Key? key,
    required this.inserirEditarRestricaoStore,
    required this.getGrupoDeRestricaoStore,
    required this.getCentroDeTrabalhoStore,
    required this.getTurnoDeTrabalhoStore,
    required this.restricaoFormController,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<RestricaoFormPage> createState() => _RestricaoFormPageState();
}

class _RestricaoFormPageState extends State<RestricaoFormPage> {
  final pageNotifier = ValueNotifier(0);
  final adaptiveModalNotifier = ValueNotifier(false);
  final dadosGeraisFormKey = GlobalKey<FormState>();
  final capacidadeFormKey = GlobalKey<FormState>();
  final disponibilidadeFormKey = GlobalKey<FormState>();
  final indisponibilidadeFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    widget.restricaoFormController.restricao = RestricaoAggregate.empty();
    widget.restricaoFormController.indisponibilidade = null;
  }

  @override
  Widget build(BuildContext context) {
    final desktopRestricaoFormPage = DesktopRestricaoFormPage(
      pageNotifier: pageNotifier,
      dadosGeraisFormKey: dadosGeraisFormKey,
      capacidadeFormKey: capacidadeFormKey,
      disponibilidadeFormKey: disponibilidadeFormKey,
      indisponibilidadeFormKey: indisponibilidadeFormKey,
      inserirEditarRestricaoStore: widget.inserirEditarRestricaoStore,
      getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
      getCentroDeTrabalhoStore: widget.getCentroDeTrabalhoStore,
      getTurnoDeTrabalhoStore: widget.getTurnoDeTrabalhoStore,
      restricaoFormController: widget.restricaoFormController,
      scaffoldController: widget.scaffoldController,
      connectionStore: widget.connectionStore,
    );

    return ValueListenableBuilder(
        valueListenable: adaptiveModalNotifier,
        builder: (context, value, child) {
          return AdaptiveRedirectorPage(
            mobilePage: MobileRestricaoFormPage(
              pageNotifier: pageNotifier,
              dadosGeraisFormKey: dadosGeraisFormKey,
              capacidadeFormKey: capacidadeFormKey,
              disponibilidadeFormKey: disponibilidadeFormKey,
              indisponibilidadeFormKey: indisponibilidadeFormKey,
              inserirEditarRestricaoStore: widget.inserirEditarRestricaoStore,
              getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
              getCentroDeTrabalhoStore: widget.getCentroDeTrabalhoStore,
              getTurnoDeTrabalhoStore: widget.getTurnoDeTrabalhoStore,
              restricaoFormController: widget.restricaoFormController,
              scaffoldController: widget.scaffoldController,
              connectionStore: widget.connectionStore,
              adaptiveModalNotifier: adaptiveModalNotifier,
            ),
            tabletPage: desktopRestricaoFormPage,
            desktopPage: desktopRestricaoFormPage,
          );
        });
  }
}
