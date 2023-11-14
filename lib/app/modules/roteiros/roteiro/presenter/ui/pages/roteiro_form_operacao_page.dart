import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_material_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/mobile/widgets/mobile_operacao_form_widget.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/web/widgets/desktop_operacao_form_widget.dart';

class RoteiroFormOperacaoPage extends StatelessWidget {
  final OperacaoController operacaoController;
  final GetUnidadeStore getUnidadeStore;
  final GetCentroDeTrabalhoStore getCentroDeTrabalhoStore;
  final GetProdutoStore getProdutoStore;
  final GetMaterialStore getMaterialStore;
  final GetGrupoDeRecursoStore getGrupoDeRecursoStore;
  final GetGrupoDeRestricaoStore getGrupoDeRestricaoStore;

  const RoteiroFormOperacaoPage({
    super.key,
    required this.operacaoController,
    required this.getUnidadeStore,
    required this.getCentroDeTrabalhoStore,
    required this.getProdutoStore,
    required this.getMaterialStore,
    required this.getGrupoDeRecursoStore,
    required this.getGrupoDeRestricaoStore,
  });

  @override
  Widget build(BuildContext context) {
    final desktopOperacaoFormWidget = DesktopOperacaoFormWidget(
      operacaoController: operacaoController,
      getUnidadeStore: getUnidadeStore,
      getCentroDeTrabalhoStore: getCentroDeTrabalhoStore,
      getProdutoStore: getProdutoStore,
      getMaterialStore: getMaterialStore,
      getGrupoDeRecursoStore: getGrupoDeRecursoStore,
      getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
    );

    final mobileOperacaoFormWidget = MobileOperacaoFormWidget(
      operacaoController: operacaoController,
      getUnidadeStore: getUnidadeStore,
      getCentroDeTrabalhoStore: getCentroDeTrabalhoStore,
      getProdutoStore: getProdutoStore,
      getMaterialStore: getMaterialStore,
      getGrupoDeRecursoStore: getGrupoDeRecursoStore,
      getGrupoDeRestricaoStore: getGrupoDeRestricaoStore,
    );

    return AdaptiveRedirectorPage(
      mobilePage: mobileOperacaoFormWidget,
      tabletPage: desktopOperacaoFormWidget,
      desktopPage: desktopOperacaoFormWidget,
    );
  }
}
