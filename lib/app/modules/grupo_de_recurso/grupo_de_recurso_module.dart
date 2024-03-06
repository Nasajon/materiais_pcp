import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/repositories/grupo_de_recursos_repository.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/usecases/delete_grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/usecases/get_grupo_de_recurso_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/infra/datasources/remote/grupo_de_recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/controllers/grupo_de_recurso_controller.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/ui/pages/grupo_de_recurso_form_page.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/ui/pages/grupo_de_recurso_list_page.dart';
import 'package:pcp_flutter/app/modules/pcp_module.dart';

import 'domain/usecases/get_grupo_de_recurso_by_id_usecase.dart';
import 'domain/usecases/get_grupo_de_recurso_list_usecase.dart';
import 'domain/usecases/save_grupo_de_recurso_usecase.dart';
import 'external/datasources/remote/grupo_de_recurso_datasource_impl.dart';
import 'infra/repositories/grupo_de_recurso_repository_impl.dart';
import 'presenter/stores/grupo_de_recurso_form_store.dart';
import 'presenter/stores/grupo_de_recurso_list_store.dart';

class GrupoDeRecursoModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      MfeModule(
        title: translation.titles.gruposDeRecursos,
        section: 'PCP',
        controller: MfeController(),
        onPressed: () => Modular.to.pushNamed(NavigationRouter.gruposDeRecursosModule.path),
      ),
      child: (context, mfe) => NhidsLaunchpadSimpleCard(mfe: mfe),
    );
  }

  @override
  List<Module> get imports => [PcpModule()];

  @override
  void binds(Injector i) {
    i
      //DataSources
      ..addLazySingleton<GrupoDeRecursoDatasource>(GrupoDeRecursoDatasourceImpl.new)

      //Repositories
      ..addLazySingleton<GrupoDeRecursosRepository>(GrupoDeRecursoRepositoryImpl.new)

      //UseCases
      ..addLazySingleton<GetGrupoDeRecursoListUsecase>(GetGrupoDeRecursoListUsecaseImpl.new)
      ..addLazySingleton<GetGrupoDeRecursoRecenteUsecase>(GetGrupoDeRecursoRecenteUsecaseImpl.new)
      ..addLazySingleton<GetGrupoDeRecursoByIdUsecase>(GetGrupoDeRecursoByIdUsecaseImpl.new)
      ..addLazySingleton<SaveGrupoDeRecursoUsecase>(SaveGrupoDeRecursoUsecaseImpl.new)
      ..addLazySingleton<DeleteGrupoDeRecursoUsecase>(DeleteGrupoDeRecursoUsecaseImpl.new)

      //Stores
      ..addLazySingleton(GrupoDeRecursoListStore.new)
      ..add(GrupoDeRecursoFormStore.new)

      //Controller
      ..add(GrupoDeRecursoController.new);
  }

  @override
  void routes(RouteManager r) {
    r //
      ..child(
        NavigationRouter.startModule.module,
        child: (context) => GrupoDeRecursoListPage(
          grupoDeRecursoStore: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.createModule.module,
        child: (context) => GrupoDeRecursoFormPage(
          grupoDeRecursoFormStore: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
          grupoDeRecursoController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.updateModule.module,
        child: (context) => GrupoDeRecursoFormPage(
          id: r.args.params['id'],
          grupoDeRecursoFormStore: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
          grupoDeRecursoController: context.read(),
        ),
      );
  }
}
