import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/inserir_editar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/widgets/desktop_horario_form_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/widgets/desktop_turno_trabalho_dados_gerais_form_widget.dart';

class DesktopTurnoTrabalhoVisualizarPage extends StatefulWidget {
  final int currentPage;
  final InserirEditarTurnoTrabalhoStore inserirEditarTurnoTrabalhoStore;
  final TurnoTrabalhoListStore turnoTrabalhoListStore;
  final TurnoTrabalhoAggregate? turnoTrabalhoAggregate;
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final PageController pageController;

  const DesktopTurnoTrabalhoVisualizarPage({
    Key? key,
    required this.currentPage,
    required this.inserirEditarTurnoTrabalhoStore,
    required this.turnoTrabalhoListStore,
    required this.turnoTrabalhoAggregate,
    required this.turnoTrabalhoFormController,
    required this.scaffoldController,
    required this.connectionStore,
    required this.pageController,
  }) : super(key: key);

  @override
  State<DesktopTurnoTrabalhoVisualizarPage> createState() => _DesktopTurnoTrabalhoVisualizarPageState();
}

class _DesktopTurnoTrabalhoVisualizarPageState extends State<DesktopTurnoTrabalhoVisualizarPage> {
  final dadosGeraisFormKey = GlobalKey<FormState>();
  final horariosFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;

    return RxBuilder(builder: (_) {
      return CustomScaffold.titleString(
        '${widget.turnoTrabalhoFormController.turnoTrabalho.codigo} - ${widget.turnoTrabalhoFormController.turnoTrabalho.nome}',
        controller: widget.scaffoldController,
        alignment: Alignment.centerLeft,
        onIconTap: () => Modular.to.pop(),
        actions: [
          InternetButtonIconWidget(connectionStore: widget.connectionStore),
        ],
        tabStatusButtons: [
          TabStatusButton(
            title: l10n.fields.dadosGerais,
            select: widget.currentPage == 0,
            onTap: () => widget.pageController.jumpToPage(0),
          ),
          TabStatusButton(
            title: l10n.fields.horario,
            select: widget.currentPage == 1,
            onTap: () => widget.pageController.jumpToPage(1),
          ),
        ],
        body: PageView(
          controller: widget.pageController,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 52, bottom: 20),
              child: DesktopTurnoTrabalhoDadosGeraisFormWidget(
                turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
                formKey: dadosGeraisFormKey,
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1266),
                  padding: const EdgeInsets.all(52),
                  child: DesktopHorarioFormWidget(
                    turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
                    formKey: horariosFormKey,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Visibility(
          visible:
              widget.turnoTrabalhoAggregate != null && widget.turnoTrabalhoAggregate != widget.turnoTrabalhoFormController.turnoTrabalho,
          child: TripleBuilder<InserirEditarTurnoTrabalhoStore, TurnoTrabalhoAggregate?>(
            store: widget.inserirEditarTurnoTrabalhoStore,
            builder: (context, triple) {
              final turnoTrabalho = triple.state;

              if (triple.isLoading == false && turnoTrabalho != null) {
                widget.turnoTrabalhoListStore.updateTurnoTrabalho(turnoTrabalho);
                Modular.to.pop();
              }

              return ContainerNavigationBarWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                        title: l10n.fields.voltar,
                        isEnabled: !triple.isLoading,
                        onPressed: () {
                          Modular.to.pop();
                        }),
                    const SizedBox(width: 10),
                    CustomPrimaryButton(
                      title: l10n.fields.salvar,
                      isLoading: triple.isLoading,
                      onPressed: () async {
                        widget.inserirEditarTurnoTrabalhoStore.editarTurnoTrabalho(widget.turnoTrabalhoFormController.turnoTrabalho);
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
