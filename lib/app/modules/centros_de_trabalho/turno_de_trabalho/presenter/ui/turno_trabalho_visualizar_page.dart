// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/get_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/inserir_editar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/mobile/mobile_turno_trabalho_visualizar_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/desktop_turno_trabalho_visualizar_page.dart';

class TurnoTrabalhoVisualizarPage extends StatefulWidget {
  final String id;
  final InserirEditarTurnoTrabalhoStore inserirEditarTurnoTrabalhoStore;
  final TurnoTrabalhoListStore turnoTrabalhoListStore;
  final GetTurnoTrabalhoPorIdStore getTurnoTrabalhoPorIdStore;
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const TurnoTrabalhoVisualizarPage({
    Key? key,
    required this.id,
    required this.inserirEditarTurnoTrabalhoStore,
    required this.turnoTrabalhoListStore,
    required this.getTurnoTrabalhoPorIdStore,
    required this.turnoTrabalhoFormController,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<TurnoTrabalhoVisualizarPage> createState() => _TurnoTrabalhoVisualizarPageState();
}

class _TurnoTrabalhoVisualizarPageState extends State<TurnoTrabalhoVisualizarPage> {
  int _currentPage = 0;
  final pageController = PageController(initialPage: 0);
  late final Disposer getTurnoTrabalhoDisposer;
  TurnoTrabalhoAggregate? turnoTrabalhoAggregate;

  @override
  void initState() {
    super.initState();

    widget.getTurnoTrabalhoPorIdStore.getTurnoTrabalhoPorId(widget.id);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getTurnoTrabalhoDisposer = widget.getTurnoTrabalhoPorIdStore.observer(
        onState: (state) {
          setState(() {
            if (state != null) {
              turnoTrabalhoAggregate = state.copyWith();
              widget.turnoTrabalhoFormController.turnoTrabalho = state.copyWith();
            }
          });
        },
      );

      pageController.addListener(() {
        setState(() {
          if (pageController.page != null) {
            _currentPage = pageController.page!.round();
          }
        });
      });
    });
  }

  @override
  void dispose() {
    getTurnoTrabalhoDisposer();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.getTurnoTrabalhoPorIdStore.isLoading && widget.getTurnoTrabalhoPorIdStore.state == null) {
      return Container();
    }

    final desktopTurnoTrabalhoVisualizar = DesktopTurnoTrabalhoVisualizarPage(
      currentPage: _currentPage,
      inserirEditarTurnoTrabalhoStore: widget.inserirEditarTurnoTrabalhoStore,
      turnoTrabalhoListStore: widget.turnoTrabalhoListStore,
      turnoTrabalhoAggregate: turnoTrabalhoAggregate,
      turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
      scaffoldController: widget.scaffoldController,
      connectionStore: widget.connectionStore,
      pageController: pageController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileTurnoTrabalhoVisualizarPage(
        currentPage: _currentPage,
        inserirEditarTurnoTrabalhoStore: widget.inserirEditarTurnoTrabalhoStore,
        turnoTrabalhoListStore: widget.turnoTrabalhoListStore,
        turnoTrabalhoAggregate: turnoTrabalhoAggregate,
        turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
        scaffoldController: widget.scaffoldController,
        connectionStore: widget.connectionStore,
        pageController: pageController,
      ),
      tabletPage: desktopTurnoTrabalhoVisualizar,
      desktopPage: desktopTurnoTrabalhoVisualizar,
    );
  }
}
