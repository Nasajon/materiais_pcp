import 'package:flutter/cupertino.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/presenter/widgets/card_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/domain/usecases/delete_grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/external/datasources/local/grupo_de_recurso_local_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/controllers/grupo_de_recurso_controller.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/ui/pages/grupo_de_recurso_form_page.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/ui/pages/grupo_de_recurso_list_page.dart';

import 'domain/usecases/get_grupo_de_recurso_by_id_usecase.dart';
import 'domain/usecases/get_grupo_de_recurso_list_usecase.dart';
import 'domain/usecases/save_grupo_de_recurso_usecase.dart';
import 'external/datasources/remote/grupo_de_recurso_datasource_impl.dart';
import 'infra/repositories/grupo_de_recurso_repository_impl.dart';
import 'presenter/stores/grupo_de_recurso_form_store.dart';
import 'presenter/stores/grupo_de_recurso_list_store.dart';
import 'presenter/ui/widgets/grupo_de_recurso_card.dart';

class GrupoDeRecursoModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [GrupoDeRecursoCard(context: context)];
  }

  @override
  List<Bind> get binds => [
        //DataSources
        Bind.lazySingleton((i) => GrupoDeRecursoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GrupoDeRecursoLocalDatasourceImpl(i())),

        Bind.lazySingleton((i) => GrupoDeRecursoDatasourceImpl(i()), export: true),
        Bind.lazySingleton((i) => GrupoDeRecursoLocalDatasourceImpl(i()), export: true),

        //Repositories
        Bind.lazySingleton((i) => GrupoDeRecursoRepositoryImpl(i(), i(), i())),

        Bind.lazySingleton((i) => GrupoDeRecursoRepositoryImpl(i(), i(), i()), export: true),

        //UseCases
        Bind.lazySingleton((i) => GetGrupoDeRecursoListUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoByIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => SaveGrupoDeRecursoUsecaseImpl(i())),
        Bind.lazySingleton((i) => DeleteGrupoDeRecursoUsecaseImpl(i())),

        Bind.lazySingleton((i) => GetGrupoDeRecursoListUsecaseImpl(i()), export: true),

        //Stores
        Bind.lazySingleton((i) => GrupoDeRecursoListStore(i(), i())),
        Bind.factory((i) => GrupoDeRecursoFormStore(i(), i())),

        Bind.lazySingleton((i) => GrupoDeRecursoListStore(i(), i()), export: true),

        //Controller
        Bind.factory((i) => GrupoDeRecursoController())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => GrupoDeRecursoListPage(
            grupoDeRecursoStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          '/new',
          child: (context, args) => GrupoDeRecursoFormPage(
            grupoDeRecursoFormStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
            grupoDeRecursoController: context.read(),
          ),
        ),
        ChildRoute(
          '/:id',
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
