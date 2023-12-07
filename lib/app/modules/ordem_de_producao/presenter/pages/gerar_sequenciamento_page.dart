// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/desktop_gerar_sequenciamento_page.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/gerar_sequenciamento_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_cliente_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_ordem_de_producao_por_id_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/inserir_editar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/sequenciar_ordem_de_producao_store.dart';

import 'package:flutter_core/ana_core.dart';

class GerarSequenciamentoPage extends StatefulWidget {
  final String id;
  final GetOrdemDeProducaoPorIdStore getOrdemDeProducaoPorIdStore;
  final ConfirmarSequenciamentoStore confirmarSequenciamentoStore;
  final InserirEditarOrdemDeProducaoStore inserirEditarOrdemDeProducaoStore;
  final GerarSequenciamentoStore gerarSequenciamentoStore;
  final GetProdutoStore getProdutoStore;
  final GetRoteiroStore getRoteiroStore;
  final GetClienteStore getClienteStore;
  final GetOperacaoStore getOperacaoStore;
  final SequenciamentoController sequenciamentoController;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;
  final OrdemDeProducaoController ordemDeProducaoController;

  const GerarSequenciamentoPage({
    Key? key,
    required this.id,
    required this.getOrdemDeProducaoPorIdStore,
    required this.confirmarSequenciamentoStore,
    required this.inserirEditarOrdemDeProducaoStore,
    required this.gerarSequenciamentoStore,
    required this.getProdutoStore,
    required this.getRoteiroStore,
    required this.getClienteStore,
    required this.getOperacaoStore,
    required this.sequenciamentoController,
    required this.connectionStore,
    required this.scaffoldController,
    required this.ordemDeProducaoController,
  }) : super(key: key);

  @override
  State<GerarSequenciamentoPage> createState() => GerarSequenciamentoPageState();
}

class GerarSequenciamentoPageState extends State<GerarSequenciamentoPage> {
  GetOrdemDeProducaoPorIdStore get getOrdemDeProducaoPorIdStore => widget.getOrdemDeProducaoPorIdStore;
  ConfirmarSequenciamentoStore get confirmarSequenciamentoStore => widget.confirmarSequenciamentoStore;
  InserirEditarOrdemDeProducaoStore get inserirEditarOrdemDeProducaoStore => widget.inserirEditarOrdemDeProducaoStore;
  GerarSequenciamentoStore get gerarSequenciamentoStore => widget.gerarSequenciamentoStore;
  GetProdutoStore get getProdutoStore => widget.getProdutoStore;
  GetRoteiroStore get getRoteiroStore => widget.getRoteiroStore;
  GetClienteStore get getClienteStore => widget.getClienteStore;
  GetOperacaoStore get getOperacaoStore => widget.getOperacaoStore;
  SequenciamentoController get sequenciamentoController => widget.sequenciamentoController;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  OrdemDeProducaoController get ordemDeProducaoController => widget.ordemDeProducaoController;

  final formKey = GlobalKey<FormState>();
  final ordemDeProducaoOld = ValueNotifier<OrdemDeProducaoAggregate?>(null);

  late final Disposer getOperacaoDispose;

  @override
  void initState() {
    super.initState();
    final id = widget.id;
    sequenciamentoController.sequenciamento = SequenciamentoAggregate.empty();
    sequenciamentoController.ordensIdsNotifier.value = [];
    sequenciamentoController.recursosIdsNotifier.value = [];

    getOrdemDeProducaoPorIdStore.getOrdem(id);

    getOperacaoDispose = getOperacaoStore.observer(onState: (state) {
      state.forEach(
        (operacao) => operacao.grupoDeRecursos.forEach(
          (grupoDeRecurso) => grupoDeRecurso.recursos.forEach(
            (recurso) {
              if (!sequenciamentoController.recursosIds.contains(recurso.id)) {
                sequenciamentoController.addRecursoId(recurso.id);
              }
            },
          ),
        ),
      );

      state.forEach(
        (operacao) => operacao.grupoDeRecursos.forEach(
          (grupoDeRecurso) => grupoDeRecurso.recursos.forEach(
            (recurso) => recurso.grupoDeRestricoes.forEach(
              (grupoDeRestricao) => grupoDeRestricao.restricoes.forEach(
                (restricao) {
                  if (!sequenciamentoController.restricaoIds.contains(restricao.id)) {
                    sequenciamentoController.addRestricaoId(restricao.id);
                  }
                },
              ),
            ),
          ),
        ),
      );

      sequenciamentoController.addOrdemId(ordemDeProducaoController.ordemDeProducao.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<GetOrdemDeProducaoPorIdStore, OrdemDeProducaoAggregate?>(
      store: getOrdemDeProducaoPorIdStore,
      onLoading: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      onState: (context, state) {
        ordemDeProducaoController.ordemDeProducao = state?.copyWith() ?? OrdemDeProducaoAggregate.empty();
        ordemDeProducaoOld.value = state?.copyWith();
        getOperacaoStore.getList(ordemDeProducaoController.ordemDeProducao.roteiro.id);

        final desktopPage = DesktopGerarSequenciamentoPage(
          gerarSequenciamentoStore: gerarSequenciamentoStore,
          confirmarSequenciamentoStore: confirmarSequenciamentoStore,
          inserirEditarOrdemDeProducaoStore: inserirEditarOrdemDeProducaoStore,
          getProdutoStore: getProdutoStore,
          getRoteiroStore: getRoteiroStore,
          getClienteStore: getClienteStore,
          getOperacaoStore: getOperacaoStore,
          sequenciamentoController: sequenciamentoController,
          connectionStore: connectionStore,
          scaffoldController: scaffoldController,
          ordemDeProducaoController: ordemDeProducaoController,
          formKey: formKey,
        );
        final mobilePage = Container();

        return AdaptiveRedirectorPage(
          mobilePage: mobilePage,
          tabletPage: desktopPage,
          desktopPage: desktopPage,
        );
      },
    );
  }
}
