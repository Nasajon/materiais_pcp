import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/presenter/presenter.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_list_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/external/datasources/remote/remote_restricao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/infra/repositories/restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/restricao_list_page.dart';

import 'presenter/ui/widgets/restricao_card.dart';

class RestricaoModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [RestricaoCard(context: context)];
  }

  @override
  List<Bind> get binds => [
        //Datasource
        Bind.lazySingleton((i) => RemoteRestricaoDatasourceImpl(i())),

        //Repositories
        Bind.lazySingleton((i) => RestricaoRepositoryImpl(i())),

        //Usecase
        Bind.lazySingleton((i) => GetListRestricaoUsecaseImpl(i())),

        TripleBind.lazySingleton((i) => RestricaoListStore(i())),
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
      ];
}
