// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/roteiro_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_material_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/inserir_editar_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/roteiro_list_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/mobile/mobile_roteiro_form_page.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/desktop_roteiro_form_page.dart';

class RoteiroFormPage extends StatefulWidget {
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

  const RoteiroFormPage({
    Key? key,
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
  State<RoteiroFormPage> createState() => _RoteiroFormPageState();
}

class _RoteiroFormPageState extends State<RoteiroFormPage> {
  final dadosBasicosformKey = GlobalKey<FormState>();
  final operacaoformKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final desktopForm = DesktopRoteiroFormPage(
      roteiroListStore: widget.roteiroListStore,
      inserirEditarRoteiroStore: widget.inserirEditarRoteiroStore,
      getCentroDeTrabalhoStore: widget.getCentroDeTrabalhoStore,
      getFichaTecnicaStore: widget.getFichaTecnicaStore,
      getGrupoDeRecursoStore: widget.getGrupoDeRecursoStore,
      getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
      getProdutoStore: widget.getProdutoStore,
      getUnidadeStore: widget.getUnidadeStore,
      scaffoldController: widget.scaffoldController,
      connectionStore: widget.connectionStore,
      roteiroController: widget.roteiroController,
      operacaoController: widget.operacaoController,
      dadosBasicosformKey: dadosBasicosformKey,
      operacaoformKey: operacaoformKey,
      getMaterialStore: widget.getMaterialStore,
    );

    final mobileForm = MobileRoteiroFormPage(
      roteiroListStore: widget.roteiroListStore,
      inserirEditarRoteiroStore: widget.inserirEditarRoteiroStore,
      getCentroDeTrabalhoStore: widget.getCentroDeTrabalhoStore,
      getFichaTecnicaStore: widget.getFichaTecnicaStore,
      getGrupoDeRecursoStore: widget.getGrupoDeRecursoStore,
      getGrupoDeRestricaoStore: widget.getGrupoDeRestricaoStore,
      getProdutoStore: widget.getProdutoStore,
      getUnidadeStore: widget.getUnidadeStore,
      scaffoldController: widget.scaffoldController,
      connectionStore: widget.connectionStore,
      roteiroController: widget.roteiroController,
      operacaoController: widget.operacaoController,
      dadosBasicosformKey: dadosBasicosformKey,
      operacaoformKey: operacaoformKey,
      getMaterialStore: widget.getMaterialStore,
    );

    return AdaptiveRedirectorPage(
      mobilePage: mobileForm,
      tabletPage: desktopForm,
      desktopPage: desktopForm,
    );
  }
}
