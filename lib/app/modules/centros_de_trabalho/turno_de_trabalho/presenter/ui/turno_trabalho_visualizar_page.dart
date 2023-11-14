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
  final pageNotifier = ValueNotifier(0);
  late final Disposer getTurnoTrabalhoDisposer;
  final dadosGeraisFormKey = GlobalKey<FormState>();
  final horariosFormKey = GlobalKey<FormState>();
  final adaptiveModalNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    widget.turnoTrabalhoFormController.turnoTrabalho = TurnoTrabalhoAggregate.empty();

    widget.getTurnoTrabalhoPorIdStore.getTurnoTrabalhoPorId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<GetTurnoTrabalhoPorIdStore, TurnoTrabalhoAggregate?>(
      store: widget.getTurnoTrabalhoPorIdStore,
      onLoading: (context) => const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(),
        ),
      ),
      onState: (context, state) {
        if (state != null) {
          widget.turnoTrabalhoFormController.turnoTrabalho = state.copyWith();
        } else {
          Modular.to.pop();
          // TODO: Adicionar uma mensagem quando não encontro o turno de trabalho
        }

        final desktopTurnoTrabalhoVisualizar = DesktopTurnoTrabalhoVisualizarPage(
          pageNotifier: pageNotifier,
          inserirEditarTurnoTrabalhoStore: widget.inserirEditarTurnoTrabalhoStore,
          turnoTrabalhoListStore: widget.turnoTrabalhoListStore,
          turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
          scaffoldController: widget.scaffoldController,
          connectionStore: widget.connectionStore,
          dadosGeraisFormKey: dadosGeraisFormKey,
          horariosFormKey: horariosFormKey,
        );

        return ValueListenableBuilder(
          valueListenable: adaptiveModalNotifier,
          builder: (context, value, child) {
            return AdaptiveRedirectorPage(
              mobilePage: MobileTurnoTrabalhoVisualizarPage(
                pageNotifier: pageNotifier,
                inserirEditarTurnoTrabalhoStore: widget.inserirEditarTurnoTrabalhoStore,
                turnoTrabalhoListStore: widget.turnoTrabalhoListStore,
                turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
                scaffoldController: widget.scaffoldController,
                connectionStore: widget.connectionStore,
                adaptiveModalNotifier: adaptiveModalNotifier,
                dadosGeraisFormKey: dadosGeraisFormKey,
              ),
              tabletPage: desktopTurnoTrabalhoVisualizar,
              desktopPage: desktopTurnoTrabalhoVisualizar,
            );
          },
        );
      },
    );
  }
}
