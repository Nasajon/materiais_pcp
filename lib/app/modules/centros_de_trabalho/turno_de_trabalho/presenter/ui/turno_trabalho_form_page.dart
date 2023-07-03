// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/inserir_editar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/mobile/mobile_turno_trabalho_form_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/desktop_turno_tabalho_form_page.dart';

class TurnoTrabalhoFormPage extends StatefulWidget {
  final InserirEditarTurnoTrabalhoStore inserirEditarTurnoTrabalhoStore;
  final TurnoTrabalhoListStore turnoTrabalhoListStore;
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const TurnoTrabalhoFormPage({
    Key? key,
    required this.inserirEditarTurnoTrabalhoStore,
    required this.turnoTrabalhoListStore,
    required this.turnoTrabalhoFormController,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<TurnoTrabalhoFormPage> createState() => _TurnoTrabalhoFormPageState();
}

class _TurnoTrabalhoFormPageState extends State<TurnoTrabalhoFormPage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    widget.turnoTrabalhoFormController.turnoTrabalho = TurnoTrabalhoAggregate.empty();
    widget.turnoTrabalhoFormController.horario = null;
  }

  @override
  Widget build(BuildContext context) {
    final desktopTurnoTrabalhoFormPage = DesktopTurnoTrabalhoFormPage(
      inserirEditarTurnoTrabalhoStore: widget.inserirEditarTurnoTrabalhoStore,
      turnoTrabalhoListStore: widget.turnoTrabalhoListStore,
      turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
      scaffoldController: widget.scaffoldController,
      connectionStore: widget.connectionStore,
      pageController: pageController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileTurnoTrabalhoFormPage(
        inserirEditarTurnoTrabalhoStore: widget.inserirEditarTurnoTrabalhoStore,
        turnoTrabalhoListStore: widget.turnoTrabalhoListStore,
        turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
        scaffoldController: widget.scaffoldController,
        connectionStore: widget.connectionStore,
        pageController: pageController,
      ),
      tabletPage: desktopTurnoTrabalhoFormPage,
      desktopPage: desktopTurnoTrabalhoFormPage,
    );
  }
}
