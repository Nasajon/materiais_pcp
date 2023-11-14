// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';

import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/mobile/mobile_ordem_de_producao_form_page.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/web/desktop_ordem_de_producao_form_page.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_cliente_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_ordem_de_producao_por_id_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/inserir_editar_ordem_de_producao_store.dart';

class OrdemDeProducaoFormPage extends StatefulWidget {
  final String? id;
  final InserirEditarOrdemDeProducaoStore inserirEditarOrdemDeProducaoStore;
  final GetOrdemDeProducaoPorIdStore getOrdemDeProducaoPorIdStore;
  final GetProdutoStore getProdutoStore;
  final GetRoteiroStore getRoteiroStore;
  final GetClienteStore getClienteStore;
  final GetOperacaoStore getOperacaoStore;
  final InternetConnectionStore connectionStore;
  final CustomScaffoldController scaffoldController;
  final OrdemDeProducaoController ordemDeProducaoController;

  const OrdemDeProducaoFormPage({
    Key? key,
    this.id,
    required this.inserirEditarOrdemDeProducaoStore,
    required this.getOrdemDeProducaoPorIdStore,
    required this.getProdutoStore,
    required this.getRoteiroStore,
    required this.getClienteStore,
    required this.getOperacaoStore,
    required this.connectionStore,
    required this.scaffoldController,
    required this.ordemDeProducaoController,
  }) : super(key: key);

  @override
  State<OrdemDeProducaoFormPage> createState() => OrdemDeProducaoFormPageState();
}

class OrdemDeProducaoFormPageState extends State<OrdemDeProducaoFormPage> {
  InserirEditarOrdemDeProducaoStore get inserirEditarOrdemDeProducaoStore => widget.inserirEditarOrdemDeProducaoStore;
  GetOrdemDeProducaoPorIdStore get getOrdemDeProducaoPorIdStore => widget.getOrdemDeProducaoPorIdStore;
  GetProdutoStore get getProdutoStore => widget.getProdutoStore;
  GetRoteiroStore get getRoteiroStore => widget.getRoteiroStore;
  GetClienteStore get getClienteStore => widget.getClienteStore;
  GetOperacaoStore get getOperacaoStore => widget.getOperacaoStore;
  CustomScaffoldController get scaffoldController => widget.scaffoldController;
  InternetConnectionStore get connectionStore => widget.connectionStore;
  OrdemDeProducaoController get ordemDeProducaoController => widget.ordemDeProducaoController;

  final formKey = GlobalKey<FormState>();
  final ordemDeProducaoOld = ValueNotifier<OrdemDeProducaoAggregate?>(null);

  @override
  void initState() {
    super.initState();
    final id = widget.id;

    if (id != null) {
      getOrdemDeProducaoPorIdStore.getOrdem(id);
    }
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

        final desktopPage = DesktopOrdemDeProducaoFormPage(
          inserirEditarOrdemDeProducaoStore: inserirEditarOrdemDeProducaoStore,
          ordemDeProducaoOld: ordemDeProducaoOld,
          getOrdemDeProducaoPorIdStore: getOrdemDeProducaoPorIdStore,
          getProdutoStore: getProdutoStore,
          getRoteiroStore: getRoteiroStore,
          getClienteStore: getClienteStore,
          getOperacaoStore: getOperacaoStore,
          connectionStore: connectionStore,
          scaffoldController: scaffoldController,
          ordemDeProducaoController: ordemDeProducaoController,
          formKey: formKey,
        );

        final mobilePage = MobileOrdemDeProducaoFormPage(
          inserirEditarOrdemDeProducaoStore: inserirEditarOrdemDeProducaoStore,
          ordemDeProducaoOld: ordemDeProducaoOld,
          getOrdemDeProducaoPorIdStore: getOrdemDeProducaoPorIdStore,
          getProdutoStore: getProdutoStore,
          getRoteiroStore: getRoteiroStore,
          getClienteStore: getClienteStore,
          getOperacaoStore: getOperacaoStore,
          connectionStore: connectionStore,
          scaffoldController: scaffoldController,
          ordemDeProducaoController: ordemDeProducaoController,
          formKey: formKey,
        );

        return AdaptiveRedirectorPage(
          mobilePage: mobilePage,
          tabletPage: desktopPage,
          desktopPage: desktopPage,
        );
      },
    );
  }
}
