import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/get_turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/atualizar_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/deletar_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/get_centro_trabalho_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/get_centro_trabalho_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/get_todos_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/get_turno_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/get_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/inserir_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/external/datasources/remotes/remote_centro_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/external/datasources/remotes/remote_get_turno_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/infra/datasources/remotes/remote_centro_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/infra/datasources/remotes/remote_get_turno_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/infra/repositories/centro_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/infra/repositories/get_turno_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/controllers/centro_trabalho_controller.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/redurces/get_turno_trabalho_reduce.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/stores/centro_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/stores/inserir_editar_centro_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/ui/pages/centro_trabalho_form_page.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/presenter/ui/pages/centro_trabalho_list_page.dart';
import 'package:pcp_flutter/app/modules/pcp_module.dart';

class CentroDeTrabalhoModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      MfeModule(
        title: translation.titles.centrosDeTrabalho,
        section: 'PCP',
        controller: MfeController(),
        onPressed: () => Modular.to.pushNamed(NavigationRouter.centrosDeTrabalhosModule.path),
      ),
      child: (context, mfe) => NhidsLaunchpadSimpleCard(mfe: mfe),
    );
  }

  @override
  List<Module> get imports => [PcpModule()];

  @override
  void binds(Injector i) {
    i //Datasources
      ..addLazySingleton<RemoteCentroTrabalhoDatasource>(RemoteCentroTrabalhoDatasourceImpl.new)
      ..addLazySingleton<RemoteGetTurnoTrabalhoDatasource>(RemoteGetTurnoTrabalhoDatasourceImpl.new)

      //Repositories
      ..addLazySingleton<CentroTrabalhoRepository>(CentroTrabalhoRepositoryImpl.new)
      ..addLazySingleton<GetTurnoTrabalhoRepository>(GetTurnoTrabalhoRepositoryImpl.new)

      //Usecase
      ..addLazySingleton<GetCentroTrabalhoRecenteUsecase>(GetCentroTrabalhoRecenteUsecaseImpl.new)
      ..addLazySingleton<GetTodosCentroTrabalhoUsecase>(GetTodosCentroTrabalhoUsecaseImpl.new)
      ..addLazySingleton<GetCentroTrabalhoPorIdUsecase>(GetCentroTrabalhoPorIdUsecaseImpl.new)
      ..addLazySingleton<GetTurnoCentroTrabalhoUsecase>(GetTurnoCentroTrabalhoUsecaseImpl.new)
      ..addLazySingleton<InserirCentroTrabalhoUsecase>(InserirCentroTrabalhoUsecaseImpl.new)
      ..addLazySingleton<AtualizarCentroTrabalhoUsecase>(AtualizarCentroTrabalhoUsecaseImpl.new)
      ..addLazySingleton<DeletarCentroTrabalhoUsecase>(DeletarCentroTrabalhoUsecaseImpl.new)
      ..addLazySingleton<GetTurnoTrabalhoUsecase>(GetTurnoTrabalhoUsecaseImpl.new)

      //Controllers
      ..addSingleton(CentroTrabalhoController.new)

      //Reducers
      ..addSingleton(GetTurnoTrabalhoReducer.new)

      //Stores
      ..addLazySingleton(CentroTrabalhoListStore.new)
      ..add(InserirEditarCentroTrabalhoStore.new);
  }

  @override
  void routes(RouteManager r) {
    r //
      ..child(
        NavigationRouter.startModule.module,
        child: (context) => CentroTrabalhoListPage(
          centroTrabalhoListStore: context.read(),
          scaffoldController: context.read(),
          connectionStore: context.read(),
        ),
      )
      ..child(
        NavigationRouter.createModule.module,
        child: (context) => CentroTrabalhoFormPage(
          inserirEditarCentroTrabalhoStore: context.read(),
          centroTrabalhoListStore: context.read(),
          centroTrabalhoController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.updateModule.module,
        child: (context) => CentroTrabalhoFormPage(
          id: r.args.params['id'],
          inserirEditarCentroTrabalhoStore: context.read(),
          centroTrabalhoListStore: context.read(),
          centroTrabalhoController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      );
  }
}
