import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_capacidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_disponibilidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_indisponibilidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/widgets/desktop_restricao_dados_gerais_form_widget.dart';

class DesktopRestricaoVisualizarPage extends StatefulWidget {
  final int currentPage;
  final RestricaoAggregate? restricaoAggregate;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final RestricaoFormController restricaoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final PageController pageController;

  const DesktopRestricaoVisualizarPage({
    Key? key,
    required this.currentPage,
    required this.restricaoAggregate,
    required this.getGrupoDeRestricaoStore,
    required this.restricaoFormController,
    required this.scaffoldController,
    required this.connectionStore,
    required this.pageController,
  }) : super(key: key);

  @override
  State<DesktopRestricaoVisualizarPage> createState() => _DesktopRestricaoVisualizarPageState();
}

class _DesktopRestricaoVisualizarPageState extends State<DesktopRestricaoVisualizarPage> {
  final dadosGeraisFormKey = GlobalKey<FormState>();
  final capacidadeFormKey = GlobalKey<FormState>();
  final disponibilidadeFormKey = GlobalKey<FormState>();
  final indisponibilidadeFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nLocalization;

    return RxBuilder(builder: (_) {
      return CustomScaffold.titleString(
        '${widget.restricaoFormController.restricao.codigo} - ${widget.restricaoFormController.restricao.descricao}',
        controller: widget.scaffoldController,
        alignment: Alignment.centerLeft,
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
            title: l10n.fields.capacidade,
            select: widget.currentPage == 1,
            onTap: () => widget.pageController.jumpToPage(1),
          ),
          TabStatusButton(
            title: l10n.fields.disponibilidade,
            select: widget.currentPage == 2,
            onTap: () => widget.pageController.jumpToPage(2),
          ),
          TabStatusButton(
            title: l10n.fields.indisponibilidade,
            select: widget.currentPage == 3,
            onTap: () => widget.pageController.jumpToPage(3),
          ),
        ],
        body: PageView(
          controller: widget.pageController,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 52, bottom: 20),
              child: DesktopRestricaoDadosGeraisFormWidget(
                getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                restricaoFormController: widget.restricaoFormController,
                formKey: dadosGeraisFormKey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 52, bottom: 20),
              child: DesktopCapacidadeFormWidget(
                restricaoFormController: widget.restricaoFormController,
                formKey: capacidadeFormKey,
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1266),
                  padding: const EdgeInsets.all(52),
                  child: DesktopDisponibilidadeFormWidget(
                    restricaoFormController: widget.restricaoFormController,
                    formKey: disponibilidadeFormKey,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1266),
                  padding: const EdgeInsets.all(52),
                  child: DesktopIndisponibilidadeFormWidget(
                    restricaoFormController: widget.restricaoFormController,
                    formKey: indisponibilidadeFormKey,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Visibility(
          visible: widget.restricaoAggregate != null && widget.restricaoAggregate != widget.restricaoFormController.restricao,
          child: ContainerNavigationBarWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                    title: l10n.fields.voltar,
                    isEnabled: true,
                    onPressed: () {
                      Modular.to.pop();
                    }),
                const SizedBox(width: 10),
                CustomPrimaryButton(
                  title: l10n.fields.salvar,
                  isLoading: false,
                  onPressed: () async {
                    try {
                      Modular.to.pop();
                    } finally {}
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
