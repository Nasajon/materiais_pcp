import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/pcp_module.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/repositories/get_centro_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/repositories/get_grupo_de_restricao_repository.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/repositories/get_turno_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/repositories/restricao_repository.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/delete_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/get_centro_de_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/get_grupo_de_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/get_list_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/get_restricao_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/get_restricao_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/get_turno_de_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/insert_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/update_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricao/external/datasources/remote/remote_get_centro_de_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/restricao/external/datasources/remote/remote_get_grupo_de_restricao_datasource.dart';
import 'package:pcp_flutter/app/modules/restricao/external/datasources/remote/remote_get_turno_de_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/restricao/external/datasources/remote/remote_restricao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/datasources/remote/remote_get_centro_de_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/datasources/remote/remote_get_grupo_de_restricao_datasource.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/datasources/remote/remote_get_turno_de_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/datasources/remote/remote_restricao_datasource.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/repositories/get_centro_de_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/repositories/get_grupo_de_restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/repositories/get_turno_de_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/repositories/restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/get_turno_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/inserir_editar_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/stores/restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/ui/pages/restricao_form_page.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/ui/pages/restricao_list_page.dart';
import 'package:pcp_flutter/app/modules/restricao/presenter/ui/pages/restricao_visualizar_page.dart';

class RestricaoModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      MfeModule(
        title: translation.titles.restricoes,
        section: 'PCP',
        controller: MfeController(),
        onPressed: () => Modular.to.pushNamed(NavigationRouter.restricoesModule.path),
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
    i //Datasource
      ..addLazySingleton<RemoteRestricaoDatasource>(RemoteRestricaoDatasourceImpl.new)
      ..addLazySingleton<RemoteGetGrupoDeRestricaoDatasource>(RemoteGetGrupoDeRestricaoDatasourceImpl.new)
      ..addLazySingleton<RemoteGetCentroDeTrabalhoDatasource>(RemoteGetCentroDeTrabalhoDatasourceImpl.new)
      ..addLazySingleton<RemoteGetTurnoDeTrabalhoDatasource>(RemoteGetTurnoDeTrabalhoDatasourceImpl.new)

      //Repositories
      ..addLazySingleton<RestricaoRepository>(RestricaoRepositoryImpl.new)
      ..addLazySingleton<GetGrupoDeRestricaoRepository>(GetGrupoDeRestricaoRepositoryImpl.new)
      ..addLazySingleton<GetCentroDeTrabalhoRepository>(GetCentroDeTrabalhoRepositoryImpl.new)
      ..addLazySingleton<GetTurnoDeTrabalhoRepository>(GetTurnoDeTrabalhoRepositoryImpl.new)

      //Usecase
      ..addLazySingleton<InsertRestricaoUsecase>(InsertRestricaoUsecaseImpl.new)
      ..addLazySingleton<UpdateRestricaoUsecase>(UpdateRestricaoUsecaseImpl.new)
      ..addLazySingleton<GetRestricaoRecenteUsecase>(GetRestricaoRecenteUsecaseImpl.new)
      ..addLazySingleton<GetCentroDeTrabalhoUsecase>(GetCentroDeTrabalhoUsecaseImpl.new)
      ..addLazySingleton<GetTurnoDeTrabalhoUsecase>(GetTurnoDeTrabalhoUsecaseImpl.new)
      ..addLazySingleton<GetListRestricaoUsecase>(GetListRestricaoUsecaseImpl.new)
      ..addLazySingleton<GetGrupoDeRestricaoUsecase>(GetGrupoDeRestricaoUsecaseImpl.new)
      ..addLazySingleton<GetRestricaoPorIdUsecase>(GetRestricaoPorIdUsecaseImpl.new)
      ..addLazySingleton<DeleteRestricaoUsecase>(DeleteRestricaoUsecaseImpl.new)

      //Triple
      ..addLazySingleton(RestricaoListStore.new)
      ..addLazySingleton(InserirEditarRestricaoStore.new)
      ..addLazySingleton(GetGrupoDeRestricaoStore.new)
      ..addLazySingleton(GetRestricaoStore.new)
      ..addLazySingleton(GetCentroDeTrabalhoStore.new)
      ..addLazySingleton(GetTurnoDeTrabalhoStore.new)

      //Controllers
      ..addLazySingleton(RestricaoFormController.new);
  }

  @override
  void routes(RouteManager r) {
    r //
      ..child(
        NavigationRouter.startModule.module,
        child: (context) => RestricaoListPage(
          restricaoListStore: context.read(),
          scaffoldController: context.read(),
          connectionStore: context.read(),
        ),
      )
      ..child(
        NavigationRouter.createModule.module,
        child: (context) => RestricaoFormPage(
          inserirEditarRestricaoStore: context.read(),
          getGrupoDeRestricaoStore: context.read(),
          getCentroDeTrabalhoStore: context.read(),
          getTurnoDeTrabalhoStore: context.read(),
          restricaoFormController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.updateModule.module,
        child: (context) => RestricaoVisualizarPage(
          id: r.args.params['id'],
          inserirEditarRestricaoStore: context.read(),
          getRestricaoStore: context.read(),
          getGrupoDeRestricaoStore: context.read(),
          getCentroDeTrabalhoStore: context.read(),
          getTurnoDeTrabalhoStore: context.read(),
          restricaoFormController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      );
  }
}
