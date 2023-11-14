// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/inserir_editar_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/mobile/mobile_restricao_visualizar_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/desktop_restricao_visualizar_page.dart';

class RestricaoVisualizarPage extends StatefulWidget {
  final String id;
  final InserirEditarRestricaoStore inserirEditarRestricaoStore;
  final GetRestricaoStore getRestricaoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final RestricaoFormController restricaoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const RestricaoVisualizarPage({
    Key? key,
    required this.id,
    required this.inserirEditarRestricaoStore,
    required this.getRestricaoStore,
    required this.getGrupoDeRestricaoStore,
    required this.restricaoFormController,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<RestricaoVisualizarPage> createState() => _RestricaoVisualizarPageState();
}

class _RestricaoVisualizarPageState extends State<RestricaoVisualizarPage> {
  final pageNotifier = ValueNotifier(0);
  late final Disposer getRestricaoDisposer;
  final dadosGeraisFormKey = GlobalKey<FormState>();
  final capacidadeFormKey = GlobalKey<FormState>();
  final disponibilidadeFormKey = GlobalKey<FormState>();
  final indisponibilidadeFormKey = GlobalKey<FormState>();
  final adaptiveModalNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    widget.restricaoFormController.restricao = RestricaoAggregate.empty();
    widget.restricaoFormController.indisponibilidade = null;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.getGrupoDeRestricaoStore.getList();

      widget.getRestricaoStore.getRestricaoPorId(widget.id);
      getRestricaoDisposer = widget.getRestricaoStore.observer(
        onState: (state) {
          if (state != null) {
            widget.restricaoFormController.restricao = state.copyWith();
          }
        },
      );
    });
  }

  @override
  void dispose() {
    getRestricaoDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<GetRestricaoStore, RestricaoAggregate?>(
      store: widget.getRestricaoStore,
      onLoading: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      onError: (context, error) {
        Modular.to.pop(); // TODO: Exibir uma mensagem
        return const SizedBox.shrink();
      },
      onState: (context, state) {
        final desktopRestricaoVisualizar = DesktopRestricaoVisualizarPage(
          pageNotifier: pageNotifier,
          inserirEditarRestricaoStore: widget.inserirEditarRestricaoStore,
          getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
          restricaoFormController: widget.restricaoFormController,
          scaffoldController: widget.scaffoldController,
          connectionStore: widget.connectionStore,
          dadosGeraisFormKey: dadosGeraisFormKey,
          capacidadeFormKey: capacidadeFormKey,
          disponibilidadeFormKey: disponibilidadeFormKey,
          indisponibilidadeFormKey: indisponibilidadeFormKey,
        );

        return AdaptiveRedirectorPage(
          mobilePage: MobileRestricaoVisualizarPage(
            pageNotifier: pageNotifier,
            inserirEditarRestricaoStore: widget.inserirEditarRestricaoStore,
            getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
            restricaoFormController: widget.restricaoFormController,
            scaffoldController: widget.scaffoldController,
            connectionStore: widget.connectionStore,
            dadosGeraisFormKey: dadosGeraisFormKey,
            capacidadeFormKey: capacidadeFormKey,
            disponibilidadeFormKey: disponibilidadeFormKey,
            indisponibilidadeFormKey: indisponibilidadeFormKey,
            adaptiveModalNotifier: adaptiveModalNotifier,
          ),
          tabletPage: desktopRestricaoVisualizar,
          desktopPage: desktopRestricaoVisualizar,
        );
      },
    );
  }
}
