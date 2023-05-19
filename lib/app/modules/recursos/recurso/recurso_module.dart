import 'package:flutter/cupertino.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/presenter/widgets/card_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/usecases/get_grupo_de_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/external/datasources/local/get_grupo_de_recurso_local_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/external/datasources/remote/get_grupo_de_recurso_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/infra/repositories/get_grupo_de_recurso_repository_impl.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/ui/pages/recurso_form_page.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/presenter/ui/pages/recurso_list_page.dart';

import 'domain/usecases/get_recurso_by_usecase_id.dart';
import 'domain/usecases/get_recurso_usecase_list.dart';
import 'domain/usecases/save_recurso_usecase.dart';
import 'external/datasources/remote/recurso_datasource_impl.dart';
import 'infra/repositories/recurso_repository_impl.dart';
import 'presenter/stores/recurso_form_store.dart';
import 'presenter/stores/recurso_list_store.dart';
import 'presenter/ui/widgets/recurso_card.dart';

class RecursoModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [RecursoCard(context: context)];
  }

  @override
  List<Bind> get binds => [
        //DataSources
        Bind.lazySingleton((i) => RecursoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoLocalDatasourceImpl(i())),

        //Repositories
        Bind.lazySingleton((i) => RecursoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoRepositoryImpl(i(), i(), i())),

        //UseCases
        Bind.lazySingleton((i) => GetGetRecursoListUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetRecursoByIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => SaveRecursoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoUsecaseImpl(i())),

        //Stores
        Bind.lazySingleton((i) => RecursoListStore(i())),
        Bind.lazySingleton((i) => RecursoFormStore(i(), i())),
        TripleBind.lazySingleton((i) => GetGrupoDeRecursoStore(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => RecursoListPage(
            recursoListStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          '/new',
          child: (context, args) => RecursoFormPage(
            recursoFormStore: context.read(),
            getGrupoDeRecursoStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          '/:id',
          child: (context, args) => RecursoFormPage(
            id: args.params['id'],
            recursoFormStore: context.read(),
            getGrupoDeRecursoStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
      ];
}
