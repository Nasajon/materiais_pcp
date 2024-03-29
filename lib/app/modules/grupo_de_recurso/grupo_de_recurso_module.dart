import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/usecases/delete_grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/usecases/get_grupo_de_recurso_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/controllers/grupo_de_recurso_controller.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/ui/pages/grupo_de_recurso_form_page.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/ui/pages/grupo_de_recurso_list_page.dart';

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
      SimpleCardWidget(
        title: translation.titles.gruposDeRecursos,
        section: 'PCP',
        code: 'materiais_pcp_grupo_de_recursos',
        descriptions: [],
        functions: [],
        permissions: [],
        showDemoMode: true,
        applicationID: 1,
        info: '',
        onPressed: () => Modular.to.pushNamed(NavigationRouter.gruposDeRecursosModule.path),
      ),
    );
  }

  @override
  List<Bind> get binds => [
        //DataSources
        Bind.lazySingleton((i) => GrupoDeRecursoDatasourceImpl(i())),

        //Repositories
        Bind.lazySingleton((i) => GrupoDeRecursoRepositoryImpl(i())),

        //UseCases
        Bind.lazySingleton((i) => GetGrupoDeRecursoListUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoRecenteUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoByIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => SaveGrupoDeRecursoUsecaseImpl(i())),
        Bind.lazySingleton((i) => DeleteGrupoDeRecursoUsecaseImpl(i())),

        //Stores
        Bind.lazySingleton((i) => GrupoDeRecursoListStore(i(), i(), i())),
        Bind.factory((i) => GrupoDeRecursoFormStore(i(), i())),

        //Controller
        Bind.factory((i) => GrupoDeRecursoController())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          NavigationRouter.startModule.module,
          child: (context, args) => GrupoDeRecursoListPage(
            grupoDeRecursoStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          NavigationRouter.createModule.module,
          child: (context, args) => GrupoDeRecursoFormPage(
            grupoDeRecursoFormStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
            grupoDeRecursoController: context.read(),
          ),
        ),
        ChildRoute(
          NavigationRouter.updateModule.module,
          child: (context, args) => GrupoDeRecursoFormPage(
            id: args.params['id'],
            grupoDeRecursoFormStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
            grupoDeRecursoController: context.read(),
          ),
        ),
      ];
}
