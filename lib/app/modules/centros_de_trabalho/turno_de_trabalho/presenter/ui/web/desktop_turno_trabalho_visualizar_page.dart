// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/inserir_editar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/widgets/desktop_horario_form_widget.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/web/widgets/desktop_turno_trabalho_dados_gerais_form_widget.dart';

class DesktopTurnoTrabalhoVisualizarPage extends StatefulWidget {
  final ValueNotifier<int> pageNotifier;
  final InserirEditarTurnoTrabalhoStore inserirEditarTurnoTrabalhoStore;
  final TurnoTrabalhoListStore turnoTrabalhoListStore;
  final TurnoTrabalhoAggregate? turnoTrabalhoAggregate;
  final TurnoTrabalhoFormController turnoTrabalhoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final GlobalKey<FormState> dadosGeraisFormKey;
  final GlobalKey<FormState> horariosFormKey;

  const DesktopTurnoTrabalhoVisualizarPage({
    Key? key,
    required this.pageNotifier,
    required this.inserirEditarTurnoTrabalhoStore,
    required this.turnoTrabalhoListStore,
    required this.turnoTrabalhoAggregate,
    required this.turnoTrabalhoFormController,
    required this.scaffoldController,
    required this.connectionStore,
    required this.dadosGeraisFormKey,
    required this.horariosFormKey,
  }) : super(key: key);

  @override
  State<DesktopTurnoTrabalhoVisualizarPage> createState() => _DesktopTurnoTrabalhoVisualizarPageState();
}

class _DesktopTurnoTrabalhoVisualizarPageState extends State<DesktopTurnoTrabalhoVisualizarPage> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: widget.pageNotifier.value);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.addListener(() {
        if (pageController.positions.isNotEmpty && pageController.page != null) {
          widget.pageNotifier.value = (pageController.page?.round() ?? 0);
        } else {
          widget.pageNotifier.value = pageController.initialPage;
        }
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final l10n = context.l10nLocalization;

    context.select(() => [widget.turnoTrabalhoFormController.turnoTrabalho]);

    return ValueListenableBuilder(
        valueListenable: widget.pageNotifier,
        builder: (context, page, child) {
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
                select: page == 0,
                onTap: () => pageController.jumpToPage(0),
              ),
              TabStatusButton(
                title: l10n.fields.horario,
                select: page == 1,
                onTap: () => pageController.jumpToPage(1),
              ),
            ],
            body: PageView(
              controller: pageController,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 52, bottom: 20),
                  child: DesktopTurnoTrabalhoDadosGeraisFormWidget(
                    turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
                    formKey: widget.dadosGeraisFormKey,
                  ),
                ),
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1266),
                      padding: const EdgeInsets.all(52),
                      child: DesktopHorarioFormWidget(
                        turnoTrabalhoFormController: widget.turnoTrabalhoFormController,
                        formKey: widget.horariosFormKey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Visibility(
              visible: widget.turnoTrabalhoAggregate != null &&
                  widget.turnoTrabalhoAggregate != widget.turnoTrabalhoFormController.turnoTrabalho,
              child: TripleBuilder<InserirEditarTurnoTrabalhoStore, TurnoTrabalhoAggregate?>(
                store: widget.inserirEditarTurnoTrabalhoStore,
                builder: (context, triple) {
                  final turnoTrabalho = triple.state;

                  if (triple.isLoading == false && turnoTrabalho != null) {
                    widget.turnoTrabalhoListStore.updateTurnoTrabalho(turnoTrabalho);
                    Modular.to.pop();

                    NotificationSnackBar.showSnackBar(
                      l10n.messages.editouUmEntidadeComSucesso(l10n.titles.turnosDeTrabalho),
                      themeData: themeData,
                    );
                  }

                  return ContainerNavigationBarWidget(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                            title: l10n.fields.descartar,
                            isEnabled: !triple.isLoading,
                            onPressed: () {
                              Asuka.showDialog(
                                barrierColor: Colors.black38,
                                builder: (context) {
                                  return ConfirmationModalWidget(
                                    title: l10n.titles.descartarAlteracoes,
                                    messages: l10n.messages.descatarAlteracoesEdicaoEntidade,
                                    titleCancel: l10n.fields.descartar,
                                    titleSuccess: l10n.fields.continuar,
                                    onCancel: () => Modular.to.pop(),
                                  );
                                },
                              );
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
