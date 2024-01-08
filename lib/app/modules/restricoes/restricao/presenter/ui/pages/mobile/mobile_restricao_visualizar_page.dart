// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/enums/artigo_enum.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/widgets/container_navigation_bar_widget.dart';
import 'package:pcp_flutter/app/core/widgets/internet_button_icon_widget.dart';
import 'package:pcp_flutter/app/core/widgets/notification_snack_bar.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_turno_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/inserir_editar_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/mobile/widgets/mobile_indisponibilidade_form_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/mobile/widgets/mobile_restricao_dados_gerais_form_widget.dart';

class MobileRestricaoVisualizarPage extends StatefulWidget {
  final ValueNotifier<int> pageNotifier;
  final InserirEditarRestricaoStore inserirEditarRestricaoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetTurnoDeTrabalhoStore getTurnoDeTrabalhoStore;
  final RestricaoFormController restricaoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;
  final GlobalKey<FormState> dadosGeraisFormKey;
  final GlobalKey<FormState> capacidadeFormKey;
  final GlobalKey<FormState> disponibilidadeFormKey;
  final GlobalKey<FormState> indisponibilidadeFormKey;
  final ValueNotifier<bool> adaptiveModalNotifier;

  const MobileRestricaoVisualizarPage({
    Key? key,
    required this.pageNotifier,
    required this.inserirEditarRestricaoStore,
    required this.getGrupoDeRestricaoStore,
    required this.getCentroDeTrabalhoStore,
    required this.getTurnoDeTrabalhoStore,
    required this.restricaoFormController,
    required this.scaffoldController,
    required this.connectionStore,
    required this.dadosGeraisFormKey,
    required this.capacidadeFormKey,
    required this.disponibilidadeFormKey,
    required this.indisponibilidadeFormKey,
    required this.adaptiveModalNotifier,
  }) : super(key: key);

  @override
  State<MobileRestricaoVisualizarPage> createState() => _MobileRestricaoVisualizarPageState();
}

class _MobileRestricaoVisualizarPageState extends State<MobileRestricaoVisualizarPage> {
  late final PageController pageController;

  RestricaoAggregate? oldRestricao;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.pageNotifier.value);

    oldRestricao = widget.restricaoFormController.restricao.copyWith();

    verificarPage();
  }

  void verificarPage() {
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
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    context.select(() => [
          widget.restricaoFormController.restricao,
          widget.restricaoFormController.indisponibilidade,
        ]);

    return ValueListenableBuilder(
        valueListenable: widget.pageNotifier,
        builder: (context, page, child) {
          return CustomScaffold.titleString(
            '${widget.restricaoFormController.restricao.codigo} - ${widget.restricaoFormController.restricao.descricao}',
            controller: widget.scaffoldController,
            alignment: Alignment.centerLeft,
            actions: [
              InternetButtonIconWidget(connectionStore: widget.connectionStore),
            ],
            tabStatusButtons: [
              TabStatusButton(
                title: translation.fields.dadosGerais,
                select: page == 0,
                onTap: () => pageController.jumpToPage(0),
              ),
              TabStatusButton(
                title: translation.fields.indisponibilidade,
                select: page == 1,
                onTap: () => pageController.jumpToPage(3),
              ),
            ],
            body: PageView(
              controller: pageController,
              children: [
                MobileRestricaoDadosGeraisFormWidget(
                  getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
                  getCentroDeTrabalhoStore: widget.getCentroDeTrabalhoStore,
                  getTurnoDeTrabalhoStore: widget.getTurnoDeTrabalhoStore,
                  restricaoFormController: widget.restricaoFormController,
                  formKey: widget.dadosGeraisFormKey,
                ),
                MobileIndisponibilidadeFormWidget(
                  restricaoFormController: widget.restricaoFormController,
                  adaptiveModalNotifier: widget.adaptiveModalNotifier,
                ),
              ],
            ),
            bottomNavigationBar: Visibility(
              visible: oldRestricao != null && oldRestricao != widget.restricaoFormController.restricao,
              child: TripleBuilder<InserirEditarRestricaoStore, RestricaoAggregate?>(
                store: widget.inserirEditarRestricaoStore,
                builder: (context, triple) {
                  final error = triple.error;
                  if (!triple.isLoading && error != null && error is Failure) {
                    Asuka.showDialog(
                      barrierColor: Colors.black38,
                      builder: (context) {
                        return ErrorModal(errorMessage: (triple.error as Failure).errorMessage ?? '');
                      },
                    );
                  }

                  final restricao = triple.state;
                  if (triple.isLoading == false && restricao != null && restricao != oldRestricao) {
                    oldRestricao = widget.restricaoFormController.restricao.copyWith();
                    widget.restricaoFormController.restricaoNotifyListeners();

                    NotificationSnackBar.showSnackBar(
                      translation.messages.editouAEntidadeComSucesso(translation.fields.restricao, artigo: ArtigoEnum.artigoFeminino),
                      themeData: themeData,
                    );
                  }

                  return ContainerNavigationBarWidget(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                            title: translation.fields.descartar,
                            isEnabled: !triple.isLoading,
                            onPressed: () {
                              Asuka.showDialog(
                                barrierColor: Colors.black38,
                                builder: (context) {
                                  return ConfirmationModalWidget(
                                    title: translation.titles.descartarAlteracoes,
                                    messages: translation.messages.descatarAlteracoesEdicaoEntidade,
                                    titleCancel: translation.fields.descartar,
                                    titleSuccess: translation.fields.continuar,
                                    onCancel: () => Modular.to.pop(),
                                  );
                                },
                              );
                            }),
                        const SizedBox(width: 10),
                        CustomPrimaryButton(
                          title: translation.fields.salvar,
                          isLoading: triple.isLoading,
                          onPressed: () async {
                            widget.inserirEditarRestricaoStore.editarRestricao(widget.restricaoFormController.restricao);
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
