import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/delete_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/get_centro_de_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/get_grupo_de_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/get_recurso_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/get_turno_de_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/external/datasources/remote/get_centro_de_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/external/datasources/remote/get_grupo_de_recurso_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/external/datasources/remote/remote_get_turno_de_trabalho_datasource_impl.dart';
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
      SimpleCardWidget(
        title: translation.titles.tituloRecursos,
        section: 'PCP',
        code: 'materiais_pcp_recursos',
        descriptions: [],
        functions: [],
        permissions: [],
        showDemoMode: true,
        applicationID: 1,
        info: '',
        onPressed: () => Modular.to.pushNamed(NavigationRouter.recursosModule.path),
      ),
    );
  }

  @override
  List<Bind> get binds => [
        //DataSources
        Bind.lazySingleton((i) => RecursoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetCentroDeTrabalhoDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteGetTurnoDeTrabalhoDatasourceImpl(i())),

        //Repositories
        Bind.lazySingleton((i) => RecursoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetCentroDeTrabalhoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetTurnoDeTrabalhoRepositoryImpl(i())),

        //UseCases
        Bind.lazySingleton((i) => GetRecursoListUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetRecursoRecenteUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetRecursoByIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => SaveRecursoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoUsecaseImpl(i())),
        Bind.lazySingleton((i) => DeleteRecursoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetCentroDeTrabalhoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetTurnoDeTrabalhoUsecaseImpl(i())),

        //Stores
        Bind.lazySingleton((i) => RecursoListStore(i(), i(), i())),
        Bind.factory((i) => RecursoFormStore(i(), i())),
        TripleBind.lazySingleton((i) => GetGrupoDeRecursoStore(i())),
        TripleBind.lazySingleton((i) => GetCentroDeTrabalhoStore(i())),
        TripleBind.lazySingleton((i) => GetTurnoDeTrabalhoStore(i())),

        //Controller
        Bind.lazySingleton((i) => RecursoController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          NavigationRouter.startModule.module,
          child: (context, args) => RecursoListPage(
            recursoListStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          NavigationRouter.createModule.module,
          child: (context, args) => RecursoFormPage(
            recursoFormStore: context.read(),
            getGrupoDeRecursoStore: context.read(),
            getCentroDeTrabalhoStore: context.read(),
            getTurnoDeTrabalhoStore: context.read(),
            recursoController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          NavigationRouter.updateModule.module,
          child: (context, args) => RecursoFormPage(
            id: args.params['id'],
            recursoFormStore: context.read(),
            getGrupoDeRecursoStore: context.read(),
            getCentroDeTrabalhoStore: context.read(),
            getTurnoDeTrabalhoStore: context.read(),
            recursoController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
      ];
}
