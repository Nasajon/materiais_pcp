import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_cliente_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_operacao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_produto_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/sequenciamento_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/aprovar_ordem_de_producao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/atualizar_ordem_de_producao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/deletar_ordem_de_producao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/gerar_sequenciamento_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_cliente_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_operacao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_ordem_de_producao_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_ordem_de_producao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_produto_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/inserir_ordem_de_producao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/confirmar_sequenciamento_ordem_de_producao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_get_cliente_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_get_operacao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_get_produto_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_get_roteiro_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_ordem_producao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_sequenciamento_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_cliente_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_operacao_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_produto_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_roteiro_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_ordem_de_producao_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_sequenciamento_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/get_cliente_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/get_operacao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/get_produto_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/get_roteiro_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/ordem_de_producao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/sequenciamento_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/ordem_de_producao_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/controllers/sequenciamento_controller.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/gerar_sequenciamento_page.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/ordem_de_producao_form_page.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/pages/ordem_de_producao_list_page.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/aprovar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/deletar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/gerar_sequenciamento_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_cliente_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_operacao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_ordem_de_producao_por_id_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/get_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/inserir_editar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/ordem_de_producao_list_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/sequenciar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/pcp_module.dart';

class OrdemDeProducaoModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      MfeModule(
        title: translation.titles.ordemDeProducao,
        section: 'PCP',
        controller: MfeController(),
        onPressed: () => Modular.to.pushNamed(NavigationRouter.ordensDeProducoesModule.path),
      ),
      child: (context, mfe) => NhidsLaunchpadSimpleCard(
        mfe: mfe,
      ),
    );
  }

  @override
  List<Module> get imports => [PcpModule()];

  @override
  void binds(Injector i) {
    i // Datasources
      ..addLazySingleton<RemoteGetClienteDatasource>(RemoteGetClienteDatasourceImpl.new)
      ..addLazySingleton<RemoteGetOperacaoDatasource>(RemoteGetOperacaoDatasourceImpl.new)
      ..addLazySingleton<RemoteGetProdutoDatasource>(RemoteGetProdutoDatasourceImpl.new)
      ..addLazySingleton<RemoteGetRoteiroDatasource>(RemoteGetRoteiroDatasourceImpl.new)
      ..addLazySingleton<RemoteOrdemDeProducaoDatasource>(RemoteOrdemDeProducaoDatasourceImpl.new)
      ..addLazySingleton<RemoteSequenciamentoDatasource>(RemoteSequenciamentoDatasourceImpl.new)

      // Repositories
      ..addLazySingleton<GetClienteRepository>(GetClienteRepositoryImpl.new)
      ..addLazySingleton<GetOperacaoRepository>(GetOperacaoRepositoryImpl.new)
      ..addLazySingleton<GetProdutoRepository>(GetProdutoRepositoryImpl.new)
      ..addLazySingleton<GetRoteiroRepository>(GetRoteiroRepositoryImpl.new)
      ..addLazySingleton<OrdemDeProducaoRepository>(OrdemDeProducaoRepositoryImpl.new)
      ..addLazySingleton<SequenciamentoRepository>(SequenciamentoRepositoryImpl.new)

      // Usecases
      ..addLazySingleton<AtualizarOrdemDeProducaoUsecase>(AtualizarOrdemDeProducaoUsecaseImpl.new)
      ..addLazySingleton<DeletarOrdemDeProducaoUsecase>(DeletarOrdemDeProducaoUsecaseImpl.new)
      ..addLazySingleton<GetClienteUsecase>(GetClienteUsecaseImpl.new)
      ..addLazySingleton<GetOperacaoUsecase>(GetOperacaoUsecaseImpl.new)
      ..addLazySingleton<GetOrdemDeProducaoUsecase>(GetOrdemDeProducaoUsecaseImpl.new)
      ..addLazySingleton<GetOrdemDeProducaoPorIdUsecase>(GetOrdemDeProducaoPorIdUsecaseImpl.new)
      ..addLazySingleton<AprovarOrdemDeProducaoUsecase>(AprovarOrdemDeProducaoUsecaseImpl.new)
      ..addLazySingleton<GetProdutoUsecase>(GetProdutoUsecaseImpl.new)
      ..addLazySingleton<GetRoteiroUsecase>(GetRoteiroUsecaseImpl.new)
      ..addLazySingleton<InserirOrdemDeProducaoUsecase>(InserirOrdemDeProducaoUsecaseImpl.new)
      ..addLazySingleton<GerarSequenciamentoUsecase>(GerarSequenciamentoUsecaseImpl.new)
      ..addLazySingleton<ConfirmarSequenciamentoOrdemDeProducaoUsecase>(ConfirmarSequenciamentoOrdemDeProducaoUsecaseImpl.new)

      //Stores
      ..addLazySingleton(GetClienteStore.new)
      ..add(GetOperacaoStore.new)
      ..addLazySingleton(GetProdutoStore.new)
      ..addLazySingleton(GetRoteiroStore.new)
      ..addLazySingleton(DeletarOrdemDeProducaoStore.new)
      ..addLazySingleton(AprovarOrdemDeProducaoStore.new)
      ..addLazySingleton(OrdemDeProducaoListStore.new)
      ..add(GetOrdemDeProducaoStore.new)
      ..add(InserirEditarOrdemDeProducaoStore.new)
      ..add(GerarSequenciamentoStore.new)
      ..add(GetOrdemDeProducaoPorIdStore.new)
      ..add(ConfirmarSequenciamentoStore.new)

      //Controllers
      ..add(OrdemDeProducaoController.new)
      ..add(SequenciamentoController.new);
  }

  @override
  void routes(RouteManager r) {
    r //
      ..child(
        NavigationRouter.startModule.module,
        child: (context) => OrdemDeProducaoListPage(
          ordemDeProducaoListStore: context.read(),
          scaffoldController: context.read(),
          connectionStore: context.read(),
        ),
      )
      ..child(
        NavigationRouter.createModule.module,
        child: (context) => OrdemDeProducaoFormPage(
          inserirEditarOrdemDeProducaoStore: context.read(),
          getOrdemDeProducaoPorIdStore: context.read(),
          getProdutoStore: context.read(),
          getRoteiroStore: context.read(),
          getClienteStore: context.read(),
          getOperacaoStore: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
          ordemDeProducaoController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.updateModule.module,
        child: (context) => OrdemDeProducaoFormPage(
          id: r.args.params['id'],
          inserirEditarOrdemDeProducaoStore: context.read(),
          getOrdemDeProducaoPorIdStore: context.read(),
          getProdutoStore: context.read(),
          getRoteiroStore: context.read(),
          getClienteStore: context.read(),
          getOperacaoStore: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
          ordemDeProducaoController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.ordensDeProducoesSequenciamentoModule.module,
        child: (context) => GerarSequenciamentoPage(
          id: r.args.params['id'],
          confirmarSequenciamentoStore: context.read(),
          getOrdemDeProducaoPorIdStore: context.read(),
          inserirEditarOrdemDeProducaoStore: context.read(),
          getProdutoStore: context.read(),
          getRoteiroStore: context.read(),
          getClienteStore: context.read(),
          getOperacaoStore: context.read(),
          getOrdemDeProducaoStore: context.read(),
          gerarSequenciamentoStore: context.read(),
          sequenciamentoController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
          ordemDeProducaoController: context.read(),
        ),
      );
  }
}
