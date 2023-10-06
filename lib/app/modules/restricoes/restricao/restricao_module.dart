import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/delete_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_grupo_de_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_list_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_restricao_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/insert_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/update_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/external/datasources/remote/remote_get_grupo_de_restricao_datasource.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/external/datasources/remote/remote_restricao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/infra/repositories/get_grupo_de_restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/infra/repositories/restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/controllers/restricao_form_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/get_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/inserir_editar_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/restricao_form_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/restricao_list_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/ui/pages/restricao_visualizar_page.dart';

class RestricaoModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      SimpleCardWidget(
        title: translation.titles.restricoes,
        section: 'PCP',
        code: 'materiais_pcp_restricao',
        descriptions: [],
        functions: [],
        permissions: [],
        showDemoMode: true,
        applicationID: 1,
        info: '',
        onPressed: () => Modular.to.pushNamed('/pcp/restricoes/'),
      ),
    );
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
        Bind.lazySingleton((i) => InsertRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => UpdateRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetListRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetRestricaoPorIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => DeleteRestricaoUsecaseImpl(i())),

        //Triple
        TripleBind.lazySingleton((i) => RestricaoListStore(i(), i())),
        TripleBind.lazySingleton((i) => InserirEditarRestricaoStore(i(), i())),
        TripleBind.lazySingleton((i) => GetGrupoDeRestricaoStore(i())),
        TripleBind.lazySingleton((i) => GetRestricaoStore(i())),

        //Controllers
        Bind.lazySingleton((i) => RestricaoFormController()),
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
            inserirEditarRestricaoStore: context.read(),
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
            inserirEditarRestricaoStore: context.read(),
            getRestricaoStore: context.read(),
            getGrupoDeRestricaoStore: context.read(),
            restricaoFormController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
      ];
}
