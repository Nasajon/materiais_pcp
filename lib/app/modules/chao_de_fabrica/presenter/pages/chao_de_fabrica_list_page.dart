// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/web/desktop_chao_de_fabrica_list_page.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_finalizar_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_recurso_store.dart';

class ChaoDeFabricaListPage extends StatefulWidget {
  final ChaoDeFabricaListStore chaoDeFabricaListStore;
  final ChaoDeFabricaCentroDeTrabalhoStore centroDeTrabalhoStore;
  final ChaoDeFabricaRecursoStore recursoStore;
  final ChaoDeFabricaApontamentoStore apontamentoStore;
  final ChaoDeFabricaFinalizarStore finalizarStore;
  final ChaoDeFabricaGrupoDeRecursoStore grupoDeRecursoStore;
  final ChaoDeFabricaAtividadeByIdStore atividadeByIdStore;
  final ChaoDeFabricaFilterController chaoDeFabricaFilterController;

  const ChaoDeFabricaListPage({
    Key? key,
    required this.chaoDeFabricaListStore,
    required this.centroDeTrabalhoStore,
    required this.recursoStore,
    required this.apontamentoStore,
    required this.finalizarStore,
    required this.grupoDeRecursoStore,
    required this.atividadeByIdStore,
    required this.chaoDeFabricaFilterController,
  }) : super(key: key);

  @override
  State<ChaoDeFabricaListPage> createState() => _ChaoDeFabricaListPageState();
}

class _ChaoDeFabricaListPageState extends State<ChaoDeFabricaListPage> {
  ChaoDeFabricaListStore get chaoDeFabricaListStore => widget.chaoDeFabricaListStore;
  ChaoDeFabricaCentroDeTrabalhoStore get centroDeTrabalhoStore => widget.centroDeTrabalhoStore;
  ChaoDeFabricaRecursoStore get recursoStore => widget.recursoStore;
  ChaoDeFabricaApontamentoStore get apontamentoStore => widget.apontamentoStore;
  ChaoDeFabricaFinalizarStore get finalizarStore => widget.finalizarStore;
  ChaoDeFabricaGrupoDeRecursoStore get grupoDeRecursoStore => widget.grupoDeRecursoStore;
  ChaoDeFabricaAtividadeByIdStore get atividadeByIdStore => widget.atividadeByIdStore;
  ChaoDeFabricaFilterController get chaoDeFabricaFilterController => widget.chaoDeFabricaFilterController;

  @override
  void initState() {
    super.initState();

    grupoDeRecursoStore.getGrupoDeRecurso(delay: Duration.zero);
    chaoDeFabricaListStore.getAtividades(chaoDeFabricaFilterController.atividadeFilter, delay: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    final desktopChaoDeFabricaListPage = DesktopChaoDeFabricaListPage(
      chaoDeFabricaListStore: chaoDeFabricaListStore,
      centroDeTrabalhoStore: centroDeTrabalhoStore,
      recursoStore: recursoStore,
      apontamentoStore: apontamentoStore,
      finalizarStore: finalizarStore,
      grupoDeRecursoStore: grupoDeRecursoStore,
      atividadeByIdStore: atividadeByIdStore,
      chaoDeFabricaFilterController: chaoDeFabricaFilterController,
    );

    return NhidsAdaptive(
      mobilePage: Container(),
      tabletPage: Container(),
      desktopPage: desktopChaoDeFabricaListPage,
    );
  }
}
