import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
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

class OrdemDeProducaoModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      SimpleCardWidget(
        title: translation.titles.ordemDeProducao,
        section: 'PCP',
        code: 'materiais_pcp_roteiro',
        descriptions: [],
        functions: [],
        permissions: [],
        showDemoMode: true,
        applicationID: 291,
        info: '',
        onPressed: () => Modular.to.pushNamed('/pcp/ordem-de-producao/'),
      ),
    );
  }

  @override
  List<Bind<Object>> get binds => [
        // Datasources
        Bind.lazySingleton((i) => RemoteGetClienteDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteGetOperacaoDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteGetProdutoDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteGetRoteiroDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteOrdemDeProducaoDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteSequenciamentoDatasourceImpl(i())),

        // Repositories
        Bind.lazySingleton((i) => GetClienteRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetOperacaoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetProdutoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetRoteiroRepositoryImpl(i())),
        Bind.lazySingleton((i) => OrdemDeProducaoRepositoryImpl(i())),
        Bind.lazySingleton((i) => SequenciamentoRepositoryImpl(i())),

        // Usecases
        Bind.lazySingleton((i) => AtualizarOrdemDeProducaoUsecaseImpl(ordemDeProducaoRepository: i())),
        Bind.lazySingleton((i) => DeletarOrdemDeProducaoUsecaseImpl(ordemDeProducaoRepository: i())),
        Bind.lazySingleton((i) => GetClienteUsecaseImpl(getClienteRepository: i())),
        Bind.lazySingleton((i) => GetOperacaoUsecaseImpl(getOperacaoRepository: i())),
        Bind.lazySingleton((i) => GetOrdemDeProducaoUsecaseImpl(ordemDeProducaoRepository: i())),
        Bind.lazySingleton((i) => GetOrdemDeProducaoPorIdUsecaseImpl(ordemDeProducaoRepository: i())),
        Bind.lazySingleton((i) => AprovarOrdemDeProducaoUsecaseImpl(ordemDeProducaoRepository: i())),
        Bind.lazySingleton((i) => GetProdutoUsecaseImpl(getProdutoRepository: i())),
        Bind.lazySingleton((i) => GetRoteiroUsecaseImpl(getRoteiroRepository: i())),
        Bind.lazySingleton((i) => InserirOrdemDeProducaoUsecaseImpl(ordemDeProducaoRepository: i())),
        Bind.lazySingleton((i) => GerarSequenciamentoUsecaseImpl(sequenciamentoRepository: i())),
        Bind.lazySingleton((i) => ConfirmarSequenciamentoOrdemDeProducaoUsecaseImpl(sequenciamentoRepository: i())),

        //Stores
        TripleBind.lazySingleton((i) => GetClienteStore(i())),
        TripleBind.factory((i) => GetOperacaoStore(i())),
        TripleBind.lazySingleton((i) => GetProdutoStore(i())),
        TripleBind.lazySingleton((i) => GetRoteiroStore(i())),
        TripleBind.lazySingleton((i) => DeletarOrdemDeProducaoStore(i())),
        TripleBind.lazySingleton((i) => AprovarOrdemDeProducaoStore(i())),
        TripleBind.lazySingleton((i) => OrdemDeProducaoListStore(i(), i(), i())),
        TripleBind.factory((i) => GetOrdemDeProducaoStore(i())),
        TripleBind.factory((i) => InserirEditarOrdemDeProducaoStore(i(), i())),
        TripleBind.factory((i) => GerarSequenciamentoStore(i())),
        TripleBind.factory((i) => GetOrdemDeProducaoPorIdStore(i())),
        TripleBind.factory((i) => ConfirmarSequenciamentoStore(sequenciarOrdemDeProducaoUsecase: i())),

        //Controllers
        Bind.factory((i) => OrdemDeProducaoController()),
        Bind.factory((i) => SequenciamentoController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => OrdemDeProducaoListPage(
            ordemDeProducaoListStore: context.read(),
            scaffoldController: context.read(),
            connectionStore: context.read(),
          ),
        ),
        ChildRoute(
          '/new',
          child: (context, args) => OrdemDeProducaoFormPage(
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
        ),
        ChildRoute(
          '/:id',
          child: (context, args) => OrdemDeProducaoFormPage(
            id: args.params['id'],
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
        ),
        ChildRoute(
          '/:id/gerar-sequenciamento',
          child: (context, args) => GerarSequenciamentoPage(
            id: args.params['id'],
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
        ),
      ];
}
