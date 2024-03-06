import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/pcp_module.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/repositories/get_centro_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/repositories/get_grupo_de_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/repositories/get_turno_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/repositories/recurso_repository.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/delete_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/get_centro_de_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/get_grupo_de_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/get_recurso_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/get_turno_de_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/external/datasources/remote/get_centro_de_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/external/datasources/remote/get_grupo_de_recurso_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/external/datasources/remote/remote_get_turno_de_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/datasources/remote/get_grupo_de_recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/datasources/remote/recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/datasources/remote/remote_get_turno_de_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/repositories/get_centro_de_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/repositories/get_grupo_de_recurso_repository_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/repositories/get_turno_de_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/controllers/recurso_controller.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/get_turno_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/ui/pages/recurso_form_page.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/ui/pages/recurso_list_page.dart';

import 'domain/usecases/get_recurso_by_usecase_id.dart';
import 'domain/usecases/get_recurso_usecase_list.dart';
import 'domain/usecases/save_recurso_usecase.dart';
import 'external/datasources/remote/recurso_datasource_impl.dart';
import 'infra/repositories/recurso_repository_impl.dart';
import 'presenter/stores/recurso_form_store.dart';
import 'presenter/stores/recurso_list_store.dart';

class RecursoModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      MfeModule(
        title: translation.titles.tituloRecursos,
        section: 'PCP',
        controller: MfeController(),
        onPressed: () => Modular.to.pushNamed(NavigationRouter.recursosModule.path),
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
    i //DataSources
      ..addLazySingleton<RecursoDatasource>(RecursoDatasourceImpl.new)
      ..addLazySingleton<GetGrupoDeRecursoDatasource>(GetGrupoDeRecursoDatasourceImpl.new)
      ..addLazySingleton<GetCentroDeTrabalhoDatasourceImpl>(GetCentroDeTrabalhoDatasourceImpl.new)
      ..addLazySingleton<RemoteGetTurnoDeTrabalhoDatasource>(RemoteGetTurnoDeTrabalhoDatasourceImpl.new)

      //Repositories
      ..addLazySingleton<RecursoRepository>(RecursoRepositoryImpl.new)
      ..addLazySingleton<GetGrupoDeRecursoRepository>(GetGrupoDeRecursoRepositoryImpl.new)
      ..addLazySingleton<GetCentroDeTrabalhoRepository>(GetCentroDeTrabalhoRepositoryImpl.new)
      ..addLazySingleton<GetTurnoDeTrabalhoRepository>(GetTurnoDeTrabalhoRepositoryImpl.new)

      //UseCases
      ..addLazySingleton<GetRecursoListUsecase>(GetRecursoListUsecaseImpl.new)
      ..addLazySingleton<GetRecursoRecenteUsecase>(GetRecursoRecenteUsecaseImpl.new)
      ..addLazySingleton<GetRecursoByIdUsecase>(GetRecursoByIdUsecaseImpl.new)
      ..addLazySingleton<SaveRecursoUsecase>(SaveRecursoUsecaseImpl.new)
      ..addLazySingleton<GetGrupoDeRecursoUsecase>(GetGrupoDeRecursoUsecaseImpl.new)
      ..addLazySingleton<DeleteRecursoUsecase>(DeleteRecursoUsecaseImpl.new)
      ..addLazySingleton<GetCentroDeTrabalhoUsecase>(GetCentroDeTrabalhoUsecaseImpl.new)
      ..addLazySingleton<GetTurnoDeTrabalhoUsecase>(GetTurnoDeTrabalhoUsecaseImpl.new)

      //Stores
      ..addLazySingleton(RecursoListStore.new)
      ..add(RecursoFormStore.new)
      ..addLazySingleton(GetGrupoDeRecursoStore.new)
      ..addLazySingleton(GetCentroDeTrabalhoStore.new)
      ..addLazySingleton(GetTurnoDeTrabalhoStore.new)

      //Controller
      ..addLazySingleton(RecursoController.new);
  }

  @override
  void routes(RouteManager r) {
    r //
      ..child(
        NavigationRouter.startModule.module,
        child: (context) => RecursoListPage(
          recursoListStore: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.createModule.module,
        child: (context) => RecursoFormPage(
          recursoFormStore: context.read(),
          getGrupoDeRecursoStore: context.read(),
          getCentroDeTrabalhoStore: context.read(),
          getTurnoDeTrabalhoStore: context.read(),
          recursoController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.updateModule.module,
        child: (context) => RecursoFormPage(
          id: r.args.params['id'],
          recursoFormStore: context.read(),
          getGrupoDeRecursoStore: context.read(),
          getCentroDeTrabalhoStore: context.read(),
          getTurnoDeTrabalhoStore: context.read(),
          recursoController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      );
  }
}
