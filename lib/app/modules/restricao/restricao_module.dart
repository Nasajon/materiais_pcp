import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
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
        onPressed: () => Modular.to.pushNamed(NavigationRouter.restricoesModule.path),
      ),
    );
  }

  @override
  List<Bind> get binds => [
        //Datasource
        Bind.lazySingleton((i) => RemoteRestricaoDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteGetGrupoDeRestricaoDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteGetCentroDeTrabalhoDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteGetTurnoDeTrabalhoDatasourceImpl(i())),

        //Repositories
        Bind.lazySingleton((i) => RestricaoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRestricaoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetCentroDeTrabalhoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetTurnoDeTrabalhoRepositoryImpl(i())),

        //Usecase
        Bind.lazySingleton((i) => InsertRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => UpdateRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetRestricaoRecenteUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetCentroDeTrabalhoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetTurnoDeTrabalhoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetListRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetRestricaoPorIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => DeleteRestricaoUsecaseImpl(i())),

        //Triple
        TripleBind.lazySingleton((i) => RestricaoListStore(i(), i(), i())),
        TripleBind.lazySingleton((i) => InserirEditarRestricaoStore(i(), i())),
        TripleBind.lazySingleton((i) => GetGrupoDeRestricaoStore(i())),
        TripleBind.lazySingleton((i) => GetRestricaoStore(i())),
        TripleBind.lazySingleton((i) => GetCentroDeTrabalhoStore(i())),
        TripleBind.lazySingleton((i) => GetTurnoDeTrabalhoStore(i())),

        //Controllers
        Bind.lazySingleton((i) => RestricaoFormController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          NavigationRouter.startModule.module,
          child: (context, args) => RestricaoListPage(
            restricaoListStore: context.read(),
            scaffoldController: context.read(),
            connectionStore: context.read(),
          ),
        ),
        ChildRoute(
          NavigationRouter.createModule.module,
          child: (context, args) => RestricaoFormPage(
            inserirEditarRestricaoStore: context.read(),
            getGrupoDeRestricaoStore: context.read(),
            getCentroDeTrabalhoStore: context.read(),
            getTurnoDeTrabalhoStore: context.read(),
            restricaoFormController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          NavigationRouter.updateModule.module,
          child: (context, args) => RestricaoVisualizarPage(
            id: args.params['id'],
            inserirEditarRestricaoStore: context.read(),
            getRestricaoStore: context.read(),
            getGrupoDeRestricaoStore: context.read(),
            getCentroDeTrabalhoStore: context.read(),
            getTurnoDeTrabalhoStore: context.read(),
            restricaoFormController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
      ];
}
