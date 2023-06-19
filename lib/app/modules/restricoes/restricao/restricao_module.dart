import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/presenter/presenter.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_grupo_de_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_list_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_restricao_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/external/datasources/remote/remote_get_grupo_de_restricao_datasource.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/external/datasources/remote/remote_restricao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/infra/repositories/get_grupo_de_restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/infra/repositories/restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/restricao_form_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/restricao_list_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/restricao_visualizar_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/stores/get_restricao_store.dart';

import 'presenter/ui/widgets/restricao_card.dart';

class RestricaoModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [RestricaoCard(context: context)];
  }

  @override
  List<Bind> get binds => [
        //Datasource
        Bind.lazySingleton((i) => RemoteRestricaoDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteGetGrupoDeRestricaoDatasourceImpl(i())),

        //Repositories
        Bind.lazySingleton((i) => RestricaoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRestricaoRepositoryImpl(i())),

        //Usecase
        Bind.lazySingleton((i) => GetListRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetRestricaoPorIdUsecaseImpl(i())),

        //Triple
        TripleBind.lazySingleton((i) => RestricaoListStore(i())),
        TripleBind.lazySingleton((i) => GetGrupoDeRestricaoStore(i())),
        TripleBind.lazySingleton((i) => GetRestricaoStore(i())),

        //Controllers
        Bind.factory((i) => RestricaoFormController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => RestricaoListPage(
            restricaoListStore: context.read(),
            scaffoldController: context.read(),
            connectionStore: context.read(),
          ),
        ),
        ChildRoute(
          '/new',
          child: (context, args) => RestricaoFormPage(
            getGrupoDeRestricaoStore: context.read(),
            restricaoFormController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          '/:id/visualizar',
          child: (context, args) => RestricaoVisualizarPage(
            id: args.params['id'],
            getRestricaoStore: context.read(),
            getGrupoDeRestricaoStore: context.read(),
            restricaoFormController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
      ];
}
