import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_apontamento_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_atividade_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_finalizar_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/get_chao_de_fabrica_centro_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/get_chao_de_fabrica_grupo_de_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/get_chao_de_fabrica_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_apontamento_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_continuar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_finalizar_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_iniciar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_iniciar_preparacao_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_pausar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_atividade_by_id_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_centro_de_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_grupo_de_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/datasources/remote/remote_chao_de_fabrica_apontamento_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/datasources/remote/remote_chao_de_fabrica_atividade_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/datasources/remote/remote_chao_de_fabrica_finalizar_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/datasources/remote/remote_get_chao_de_fabrica_centro_de_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/datasources/remote/remote_get_chao_de_fabrica_grupo_de_recurso_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/datasources/remote/remote_get_chao_de_fabrica_recurso_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_chao_de_fabrica_apontamento_datasource.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_chao_de_fabrica_atividade_datasource.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_chao_de_fabrica_finalizar_datasource.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_get_chao_de_fabrica_centro_de_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_get_chao_de_fabrica_grupo_de_recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_get_chao_de_fabrica_recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/repositories/chao_de_fabrica_apontamento_repository_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/repositories/chao_de_fabrica_atividade_repository_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/repositories/chao_de_fabrica_finalizar_repository_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/repositories/get_chao_de_fabrica_centro_de_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/repositories/get_chao_de_fabrica_recurso_grupo_de_repository_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/repositories/get_chao_de_fabrica_recurso_repository_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/chao_de_fabrica_atividade_gestor_page.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/chao_de_fabrica_list_page.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/reducers/chao_de_fabrica_atividade_filter_reducer.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_apontamento_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_atividade_by_id_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_finalizar_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_recurso_store.dart';
import 'package:pcp_flutter/app/modules/pcp_module.dart';

class ChaoDeFabricaModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      MfeModule(
        title: translation.titles.chaoDeFabrica,
        section: 'PCP',
        controller: MfeController(),
        onPressed: () => Modular.to.pushNamed(NavigationRouter.chaoDeFabricaModule.path),
      ),
      child: (context, mfe) => NhidsLaunchpadSimpleCard(mfe: mfe),
    );
  }

  @override
  List<Module> get imports => [PcpModule()];

  @override
  void binds(Injector i) {
    i // Datasources
      ..addLazySingleton<RemoteGetChaoDeFabricaCentroDeTrabalhoDatasource>(RemoteGetChaoDeFabricaCentroDeTrabalhoDatasourceImpl.new)
      ..addLazySingleton<RemoteGetChaoDeFabricaGrupoDeRecursoDatasource>(RemoteGetChaoDeFabricaGrupoDeRecursoDatasourceImpl.new)
      ..addLazySingleton<RemoteGetChaoDeFabricaRecursoDatasource>(RemoteGetChaoDeFabricaRecursoDatasourceImpl.new)
      ..addLazySingleton<RemoteChaoDeFabricaAtividadeDatasource>(RemoteChaoDeFabricaAtividadeDatasourceImpl.new)
      ..addLazySingleton<RemoteChaoDeFabricaApontamentoDatasource>(RemoteChaoDeFabricaApontamentoDatasourceImpl.new)
      ..addLazySingleton<RemoteChaoDeFabricaFinalizarDatasource>(RemoteChaoDeFabricaFinalizarDatasourceImpl.new)

      // Repositories
      ..addLazySingleton<GetChaoDeFabricaCentroDeTrabalhoRepository>(GetChaoDeFabricaCentroDeTrabalhoRepositoryImpl.new)
      ..addLazySingleton<GetChaoDeFabricaGrupoDeRecursoRepository>(GetChaoDeFabricaGrupoDeRecursoRepositoryImpl.new)
      ..addLazySingleton<GetChaoDeFabricaRecursoRepository>(GetChaoDeFabricaRecursoRepositoryImpl.new)
      ..addLazySingleton<ChaoDeFabricaAtividadeRepository>(ChaoDeFabricaAtividadeRepositoryImpl.new)
      ..addLazySingleton<ChaoDeFabricaApontamentoRepository>(ChaoDeFabricaApontamentoRepositoryImpl.new)
      ..addLazySingleton<ChaoDeFabricaFinalizarRepository>(ChaoDeFabricaFinalizarRepositoryImpl.new)

      // Usecases
      ..addLazySingleton<ChaoDeFabricaContinuarAtividadeUsecase>(ChaoDeFabricaContinuarAtividadeUsecaseImpl.new)
      ..addLazySingleton<ChaoDeFabricaIniciarAtividadeUsecase>(ChaoDeFabricaIniciarAtividadeUsecaseImpl.new)
      ..addLazySingleton<ChaoDeFabricaIniciarPreparacaoUsecase>(ChaoDeFabricaIniciarPreparacaoUsecaseImpl.new)
      ..addLazySingleton<ChaoDeFabricaPausarAtividadeUsecase>(ChaoDeFabricaPausarAtividadeUsecaseImpl.new)
      ..addLazySingleton<GetChaoDeFabricaAtividadeUsecase>(GetChaoDeFabricaAtividadeUsecaseImpl.new)
      ..addLazySingleton<GetChaoDeFabricaAtividadeByIdUsecase>(GetChaoDeFabricaAtividadeByIdUsecaseImpl.new)
      ..addLazySingleton<GetChaoDeFabricaCentroDeTrabalhoUsecase>(GetChaoDeFabricaCentroDeTrabalhoUsecaseImpl.new)
      ..addLazySingleton<GetChaoDeFabricaGrupoDeRecursoUsecase>(GetChaoDeFabricaGrupoDeRecursoUsecaseImpl.new)
      ..addLazySingleton<GetChaoDeFabricaRecursoUsecase>(GetChaoDeFabricaRecursoUsecaseImpl.new)
      ..addLazySingleton<ChaoDeFabricaApontamentoUsecase>(ChaoDeFabricaApontamentoUsecaseImpl.new)
      ..addLazySingleton<ChaoDeFabricaFinalizarUsecase>(ChaoDeFabricaFinalizarUsecaseImpl.new)

      // Controllers
      ..addSingleton(ChaoDeFabricaFilterController.new)

      // Stores
      ..addLazySingleton(ChaoDeFabricaListStore.new)
      ..addLazySingleton(ChaoDeFabricaCentroDeTrabalhoStore.new)
      ..addLazySingleton(ChaoDeFabricaGrupoDeRecursoStore.new)
      ..addLazySingleton(ChaoDeFabricaRecursoStore.new)
      ..add(ChaoDeFabricaApontamentoStore.new)
      ..add(ChaoDeFabricaFinalizarStore.new)
      ..addLazySingleton(ChaoDeFabricaAtividadeByIdStore.new)

      // Reducers
      ..addSingleton(
        ChaoDeFabricaAtividadeFilterReducer.new,
      );
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        NavigationRouter.startModule.module,
        child: (context) => ChaoDeFabricaListPage(
          chaoDeFabricaListStore: context.read(),
          centroDeTrabalhoStore: context.read(),
          recursoStore: context.read(),
          apontamentoStore: context.read(),
          finalizarStore: context.read(),
          grupoDeRecursoStore: context.read(),
          atividadeByIdStore: context.read(),
          chaoDeFabricaFilterController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.updateModule.module,
        child: (context) => ChaoDeFabricaAtividadeGestorPage(
          id: r.args.params['id'],
          chaoDeFabricaListStore: context.read(),
          atividadeByIdStore: context.read(),
          apontamentoStore: context.read(),
          finalizarStore: context.read(),
        ),
      );
  }
}
