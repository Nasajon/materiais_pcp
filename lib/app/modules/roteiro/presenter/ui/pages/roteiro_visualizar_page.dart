// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/roteiro_controller.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_material_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/inserir_editar_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/stores/roteiro_list_store.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/mobile/mobile_roteiro_visualizar_page.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/web/desktop_roteiro_visualizar_page.dart';

class RoteiroVisualizarPage extends StatefulWidget {
  final String roteiroId;
  final GetRoteiroStore getRoteiroStore;
  final RoteiroListStore roteiroListStore;
  final InserirEditarRoteiroStore inserirEditarRoteiroStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetFichaTecnicaStore getFichaTecnicaStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;
  final GetProdutoStore getProdutoStore;
  final GetUnidadeStore getUnidadeStore;
  final GetMaterialStore getMaterialStore;
  final RoteiroController roteiroController;
  final OperacaoController operacaoController;
  final CustomScaffoldController scaffoldController;
  final InternetConnectionStore connectionStore;

  const RoteiroVisualizarPage({
    Key? key,
    required this.roteiroId,
    required this.getRoteiroStore,
    required this.roteiroListStore,
    required this.inserirEditarRoteiroStore,
    required this.getCentroDeTrabalhoStore,
    required this.getFichaTecnicaStore,
    required this.getGrupoDeRecursoStore,
    required this.getGrupoDeRestricaoStore,
    required this.getProdutoStore,
    required this.getUnidadeStore,
    required this.getMaterialStore,
    required this.roteiroController,
    required this.operacaoController,
    required this.scaffoldController,
    required this.connectionStore,
  }) : super(key: key);

  @override
  State<RoteiroVisualizarPage> createState() => _RoteiroVisualizarPageState();
}

class _RoteiroVisualizarPageState extends State<RoteiroVisualizarPage> {
  String get roteiroId => widget.roteiroId;
  GetRoteiroStore get getRoteiroStore => widget.getRoteiroStore;
  RoteiroListStore get roteiroListStore => widget.roteiroListStore;
  InserirEditarRoteiroStore get inserirEditarRoteiroStore => widget.inserirEditarRoteiroStore;
  GetCentroDeTrabalhoStore get getCentroDeTrabalhoStore => widget.getCentroDeTrabalhoStore;
  GetFichaTecnicaStore get getFichaTecnicaStore => widget.getFichaTecnicaStore;
  GetGrupoDeRecursoStore get getGrupoDeRecursoStore => widget.getGrupoDeRecursoStore;
  GetGrupoDeRestricaoStore get getGrupoDeRestricaoStore => widget.getGrupoDeRestricaoStore;
  GetProdutoStore get getProdutoStore => widget.getProdutoStore;
  GetUnidadeStore get getUnidadeStore => widget.getUnidadeStore;
  GetMaterialStore get getMaterialStore => widget.getMaterialStore;
  RoteiroController get roteiroController => widget.roteiroController;
  OperacaoController get operacaoController => widget.operacaoController;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;

  @override
  void initState() {
    super.initState();

    getRoteiroStore.getRoteiroPorId(roteiroId);
  }

  final dadosBasicosformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<GetRoteiroStore, RoteiroAggregate>(
      onError: (context, error) {
        return const SizedBox.shrink();
      },
      onLoading: (context) => const Center(child: CircularProgressIndicator()),
      onState: (context, state) {
        roteiroController.roteiro = state;
        roteiroController.pageIndex = 0;

        final desktopRoteiroVisualizar = DesktopRoteiroVisualizarPage(
          roteiroListStore: roteiroListStore,
          inserirEditarRoteiroStore: inserirEditarRoteiroStore,
          getCentroDeTrabalhoStore: getCentroDeTrabalhoStore,
          getFichaTecnicaStore: getFichaTecnicaStore,
          getGrupoDeRecursoStore: getGrupoDeRecursoStore,
          getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
          getProdutoStore: getProdutoStore,
          getUnidadeStore: getUnidadeStore,
          getMaterialStore: getMaterialStore,
          roteiroController: roteiroController,
          operacaoController: operacaoController,
          scaffoldController: scaffoldController,
          connectionStore: connectionStore,
          dadosBasicosformKey: dadosBasicosformKey,
        );

        final mobileRoteiroVisualizar = MobileRoteiroVisualizarPage(
          roteiroListStore: roteiroListStore,
          inserirEditarRoteiroStore: inserirEditarRoteiroStore,
          getCentroDeTrabalhoStore: getCentroDeTrabalhoStore,
          getFichaTecnicaStore: getFichaTecnicaStore,
          getGrupoDeRecursoStore: getGrupoDeRecursoStore,
          getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
          getProdutoStore: getProdutoStore,
          getUnidadeStore: getUnidadeStore,
          getMaterialStore: getMaterialStore,
          roteiroController: roteiroController,
          operacaoController: operacaoController,
          scaffoldController: scaffoldController,
          connectionStore: connectionStore,
          dadosBasicosformKey: dadosBasicosformKey,
        );

        return AdaptiveRedirectorPage(
          mobilePage: mobileRoteiroVisualizar,
          tabletPage: desktopRoteiroVisualizar,
          desktopPage: desktopRoteiroVisualizar,
        );
      },
    );
  }
}
