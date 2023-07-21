import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/mobile/mobile_restricao_visualizar_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/web/desktop_restricao_visualizar_page.dart';

class RestricaoVisualizarPage extends StatefulWidget {
  final String id;
  final GetRestricaoStore getRestricaoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final RestricaoFormController restricaoFormController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const RestricaoVisualizarPage({
    Key? key,
    required this.id,
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
  int _currentPage = 0;
  final pageController = PageController(initialPage: 0);
  late final Disposer getRestricaoDisposer;
  RestricaoAggregate? restricaoAggregate;

  @override
  void initState() {
    super.initState();

    widget.getGrupoDeRestricaoStore.getList();
    widget.getRestricaoStore.getRestricaoPorId(widget.id);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getRestricaoDisposer = widget.getRestricaoStore.observer(
        onState: (state) {
          setState(() {
            if (state != null) {
              restricaoAggregate = state.copyWith();
              widget.restricaoFormController.restricao = state.copyWith();
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
    getRestricaoDisposer();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.getRestricaoStore.isLoading && widget.getRestricaoStore.state == null) {
      return Container();
    }

    final desktopRestricaoVisualizar = DesktopRestricaoVisualizarPage(
      currentPage: _currentPage,
      restricaoAggregate: restricaoAggregate,
      getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
      restricaoFormController: widget.restricaoFormController,
      scaffoldController: widget.scaffoldController,
      connectionStore: widget.connectionStore,
      pageController: pageController,
    );

    return AdaptiveRedirectorPage(
      mobilePage: MobileRestricaoVisualizarPage(
          currentPage: _currentPage,
          restricaoAggregate: restricaoAggregate,
          getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
          restricaoFormController: widget.restricaoFormController,
          scaffoldController: widget.scaffoldController,
          connectionStore: widget.connectionStore,
          pageController: pageController),
      tabletPage: desktopRestricaoVisualizar,
      desktopPage: desktopRestricaoVisualizar,
    );
  }
}
