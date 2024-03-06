import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/pcp_module.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_centro_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_grupo_de_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_grupo_de_restricao_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_material_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_produto_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_recurso_por_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_restricao_por_grupo_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_unidade_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/deletar_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/editar_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_centro_de_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_grupo_de_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_grupo_de_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_material_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_produto_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_recurso_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_roteiro_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_roteiro_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_unidade_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/inserir_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_centro_de_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_ficha_tecnica_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_grupo_de_recurso_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_grupo_de_restricao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_material_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_produto_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_recurso_por_grupo_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_restricao_por_grupo_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_unidade_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_roteiro_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_centro_de_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_ficha_tecnica_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_grupo_de_recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_grupo_de_restricao_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_material_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_produto_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_recurso_por_grupo_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_restricao_por_grupo_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_unidade_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_roteiro_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_centro_de_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_ficha_tecnica_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_grupo_de_recurso_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_grupo_de_restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_material_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_produto_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_recurso_por_grupo_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_restricao_por_grupo_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_tipo_unidade_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/roteiro_repository_impl.dart';
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
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/roteiro_form_operacao_page.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/roteiro_form_page.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/roteiro_list_page.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/ui/pages/roteiro_visualizar_page.dart';

class RoteiroModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      MfeModule(
        title: translation.titles.roteiroDeProducao,
        section: 'PCP',
        controller: MfeController(),
        onPressed: () => Modular.to.pushNamed(NavigationRouter.roteirosModule.path),
      ),
      child: (context, mfe) => NhidsLaunchpadSimpleCard(mfe: mfe),
    );
  }

  @override
  List<Module> get imports => [PcpModule()];

  @override
  void binds(Injector i) {
    i // Centro de trabalho
      ..addLazySingleton<RemoteGetCentroDeTrabalhoDatasource>(RemoteGetCentroDeTrabalhoDatasourceImpl.new)
      ..addLazySingleton<GetCentroDeTrabalhoRepository>(GetCentroDeTrabalhoRepositoryImpl.new)
      ..addLazySingleton<GetCentroDeTrabalhoUsecase>(GetCentroDeTrabalhoUsecaseImpl.new)

      // Ficha tecnica
      ..addLazySingleton<RemoteGetFichaTecnicaDatasource>(RemoteGetFichaTecnicaDatasourceImpl.new)
      ..addLazySingleton<GetFichaTecnicaRepository>(GetFichaTecnicaRepositoryImpl.new)
      ..addLazySingleton<GetFichaTecnicaUsecase>(GetFichaTecnicaUsecaseImpl.new)

      // Grupo de recurso
      ..addLazySingleton<RemoteGetGrupoDeRecursoDatasource>(RemoteGetGrupoDeRecursoDatasourceImpl.new)
      ..addLazySingleton<GetGrupoDeRecursoRepository>(GetGrupoDeRecursoRepositoryImpl.new)
      ..addLazySingleton<GetGrupoDeRecursoUsecase>(GetGrupoDeRecursoUsecaseImpl.new)

      // Recurso
      ..addLazySingleton<RemoteGetRecursoPorGrupoDatasource>(RemoteGetRecursoPorGrupoDatasourceImpl.new)
      ..addLazySingleton<GetRecursoPorGrupoRepository>(GetRecursoPorGrupoRepositoryImpl.new)
      ..addLazySingleton<GetRecursoPorGrupoUsecase>(GetRecursoPorGrupoUsecaseImpl.new)

      // Grupo de restricao
      ..addLazySingleton<RemoteGetGrupoDeRestricaoDatasource>(RemoteGetGrupoDeRestricaoDatasourceImpl.new)
      ..addLazySingleton<GetGrupoDeRestricaoRepository>(GetGrupoDeRestricaoRepositoryImpl.new)
      ..addLazySingleton<GetGrupoDeRestricaoUsecase>(GetGrupoDeRestricaoUsecaseImpl.new)

      // Restricao
      ..addLazySingleton<RemoteGetRestricaoPorGrupoDatasource>(RemoteGetRestricaoPorGrupoDatasourceImpl.new)
      ..addLazySingleton<GetRestricaoPorGrupoRepository>(GetRestricaoPorGrupoRepositoryImpl.new)
      ..addLazySingleton<GetRestricaoPorGrupoUsecase>(GetRestricaoPorGrupoUsecaseImpl.new)

      // Material (Produtos)
      ..addLazySingleton<RemoteGetMaterialDatasource>(RemoteGetMaterialDatasourceImpl.new)
      ..addLazySingleton<GetMaterialRepository>(GetMaterialRepositoryImpl.new)
      ..addLazySingleton<GetMaterialUsecase>(GetMaterialUsecaseImpl.new)

      // Produtos
      ..addLazySingleton<RemoteGetProdutoDatasource>(RemoteGetProdutoDatasourceImpl.new)
      ..addLazySingleton<GetProdutoRepository>(GetProdutoRepositoryImpl.new)
      ..addLazySingleton<GetProdutoUsecase>(GetProdutoUsecaseImpl.new)

      // Unidades
      ..addLazySingleton<RemoteGetUnidadeDatasource>(RemoteGetUnidadeDatasourceImpl.new)
      ..addLazySingleton<GetUnidadeRepository>(GetUnidadeRepositoryImpl.new)
      ..addLazySingleton<GetUnidadeUsecase>(GetUnidadeUsecaseImpl.new)

      // Roteiro
      ..addLazySingleton<RemoteRoteiroDatasource>(RemoteRoteiroDatasourceImpl.new)
      ..addLazySingleton<RoteiroRepository>(RoteiroRepositoryImpl.new)
      ..addLazySingleton<GetRoteiroPorIdUsecase>(GetRoteiroPorIdUsecaseImpl.new)
      ..addLazySingleton<GetRoteiroRecenteUsecase>(GetRoteiroRecenteUsecaseImpl.new)
      ..addLazySingleton<GetRoteiroUsecase>(GetRoteiroUsecaseImpl.new)
      ..addLazySingleton<InserirRoteiroUsecase>(InserirRoteiroUsecaseImpl.new)
      ..addLazySingleton<EditarRoteiroUsecase>(EditarRoteiroUsecaseImpl.new)
      ..addLazySingleton<DeletarRoteiroUsecase>(DeletarRoteiroUsecaseImpl.new)

      // Stores
      ..addLazySingleton(GetCentroDeTrabalhoStore.new)
      ..addLazySingleton(GetFichaTecnicaStore.new)
      ..addLazySingleton(GetGrupoDeRecursoStore.new)
      ..addLazySingleton(GetGrupoDeRestricaoStore.new)
      ..addLazySingleton(GetProdutoStore.new)
      ..addLazySingleton(GetUnidadeStore.new)
      ..addLazySingleton(GetMaterialStore.new)
      ..addLazySingleton(GetRoteiroStore.new)
      ..addLazySingleton(RoteiroListStore.new)
      ..add(InserirEditarRoteiroStore.new)

      //Controllers
      ..add(RoteiroController.new)
      ..addLazySingleton(OperacaoController.new);
  }

  @override
  void routes(RouteManager r) {
    r //
      ..child(
        NavigationRouter.startModule.module,
        child: (context) => RoteiroListPage(
          roteiroListStore: context.read(),
          scaffoldController: context.read(),
          connectionStore: context.read(),
        ),
      )
      ..child(
        NavigationRouter.createModule.module,
        child: (context) => RoteiroFormPage(
          roteiroListStore: context.read(),
          inserirEditarRoteiroStore: context.read(),
          getCentroDeTrabalhoStore: context.read(),
          getFichaTecnicaStore: context.read(),
          getGrupoDeRecursoStore: context.read(),
          getGrupoDeRestricaoStore: context.read(),
          getProdutoStore: context.read(),
          getUnidadeStore: context.read(),
          roteiroController: context.read(),
          operacaoController: context.read(),
          scaffoldController: context.read(),
          connectionStore: context.read(),
          getMaterialStore: context.read(),
        ),
      )
      ..child(
        NavigationRouter.updateModule.module,
        child: (context) => RoteiroVisualizarPage(
          roteiroId: r.args.params['id'],
          getRoteiroStore: context.read(),
          roteiroListStore: context.read(),
          inserirEditarRoteiroStore: context.read(),
          getCentroDeTrabalhoStore: context.read(),
          getFichaTecnicaStore: context.read(),
          getGrupoDeRecursoStore: context.read(),
          getGrupoDeRestricaoStore: context.read(),
          getProdutoStore: context.read(),
          getUnidadeStore: context.read(),
          roteiroController: context.read(),
          operacaoController: context.read(),
          scaffoldController: context.read(),
          connectionStore: context.read(),
          getMaterialStore: context.read(),
        ),
      )
      ..child(
        NavigationRouter.roteirosOperacaoModule.module,
        child: (context) => RoteiroFormOperacaoPage(
          operacaoController: context.read(),
          getUnidadeStore: context.read(),
          getCentroDeTrabalhoStore: context.read(),
          getProdutoStore: context.read(),
          getMaterialStore: context.read(),
          getGrupoDeRecursoStore: context.read(),
          getGrupoDeRestricaoStore: context.read(),
        ),
      );
  }
}
