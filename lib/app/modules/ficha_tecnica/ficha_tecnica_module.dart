import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/produto_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/unidade_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/atualizar_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/deletar_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_ficha_tecnica_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_ficha_tecnica_recentes_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_produtos_por_ids_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_todas_unidades_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_todos_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_todos_produtos_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_unidade_por_ids_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/inserir_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/datasources/remotes/remote_ficha_tecnica_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/datasources/remotes/remote_produto_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/datasources/remotes/remote_unidade_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/datasources/remotes/remote_ficha_tecnica_datasource.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/datasources/remotes/remote_produto_datasource%20copy.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/datasources/remotes/remote_unidade_datasource.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/repositories/ficha_tecnica_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/repositories/produto_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/repositories/unidade_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/ficha_tecnica_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/get_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/inserir_editar_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/unidades_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/ficha_tecnica_form_page.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/ficha_tecnica_list_page.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/ficha_tecnica_visualizar_page.dart';
import 'package:pcp_flutter/app/modules/pcp_module.dart';

class FichaTecnicaModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      MfeModule(
        title: translation.titles.fichasTecnicas,
        section: 'PCP',
        controller: MfeController(),
        onPressed: () => Modular.to.pushNamed(NavigationRouter.fichasTecnicasModule.path),
      ),
      child: (context, mfe) => NhidsLaunchpadSimpleCard(mfe: mfe),
    );
  }

  @override
  List<Module> get imports => [PcpModule()];

  @override
  void binds(Injector i) {
    i //Datasources
      ..addLazySingleton<RemoteUnidadeDatasource>(RemoteUnidadeDatasourceImpl.new)
      ..addLazySingleton<RemoteProdutoDatasource>(RemoteProdutoDatasourceImpl.new)
      ..addLazySingleton<RemoteFichaTecnicaDatasource>(RemoteFichaTecnicaDatasourceImpl.new)

      //Repositories
      ..addLazySingleton<FichaTecnicaRepository>(FichaTecnicaRepositoryImpl.new)
      ..addLazySingleton<UnidadeRepository>(UnidadeRepositoryImpl.new)
      ..addLazySingleton<ProdutoRepository>(ProdutoRepositoryImpl.new)

      //Usecase
      ..addLazySingleton<AtualizarFichaTecnicaUsecase>(AtualizarFichaTecnicaUsecaseImpl.new)
      ..addLazySingleton<DeletarFichaTecnicaUsecase>(DeletarFichaTecnicaUsecaseImpl.new)
      ..addLazySingleton<GetFichaTecnicaPorIdUsecase>(GetFichaTecnicaPorIdUsecaseImpl.new)
      ..addLazySingleton<GetFichaTecnicaRecenteUsecase>(GetFichaTecnicaRecenteUsecaseImpl.new)
      ..addLazySingleton<GetTodosFichaTecnicaUsecase>(GetTodosFichaTecnicaUsecaseImpl.new)
      ..addLazySingleton<InserirFichaTecnicaUsecase>(InserirFichaTecnicaUsecaseImpl.new)
      ..addLazySingleton<GetProdutosPorIdsUsecase>(GetProdutosPorIdsUsecaseImpl.new)
      ..addLazySingleton<GetTodosProdutosUsecase>(GetTodosProdutosUsecaseImpl.new)
      ..addLazySingleton<GetUnidadesPorIdsUsecase>(GetUnidadesPorIdsUsecaseImpl.new)
      ..addLazySingleton<GetTodasUnidadesUsecase>(GetTodasUnidadesUsecaseImpl.new)

      //Controllers
      ..addLazySingleton(FichaTecnicaFormController.new)

      //Stores
      ..addLazySingleton(GetFichaTecnicaPorIdStore.new)
      ..addLazySingleton(FichaTecnicaListStore.new)
      ..add(ProdutoListStore.new)
      ..add(UnidadeListStore.new)
      ..add(InserirEditarFichaTecnicaStore.new);
  }

  @override
  void routes(RouteManager r) {
    r //
      ..child(
        NavigationRouter.startModule.module,
        child: (context) => FichaTecnicaListPage(
          connectionStore: context.read(),
          scaffoldController: context.read(),
          fichaTecnicaListStore: context.read(),
        ),
      )
      ..child(
        NavigationRouter.createModule.module,
        child: (context) => FichaTecnicaFormPage(
          produtoListStore: context.read(),
          unidadeListStore: context.read(),
          inserirEditarFichaTecnicaStore: context.read(),
          fichaTecnicaListStore: context.read(),
          fichaTecnicaFormController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.updateModule.module,
        child: (context) => FichaTecnicaVisualizarPage(
          fichaTecnicaId: r.args.params['id'],
          produtoListStore: context.read(),
          unidadeListStore: context.read(),
          inserirEditarFichaTecnicaStore: context.read(),
          fichaTecnicaListStore: context.read(),
          getFichaTecnicaPorIdStore: context.read(),
          fichaTecnicaFormController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      );
  }
}
