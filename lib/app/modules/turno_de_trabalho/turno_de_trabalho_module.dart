import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/pcp_module.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/deletar_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/editar_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/get_turno_trabalho_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/get_turno_trabalho_recentes_usecase.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/get_turnos_trabalhos_usecase.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/inserir_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/external/datasources/remote/remote_turno_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/infra/datasources/remote/remote_turno_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/infra/repositories/turno_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/stores/get_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/stores/inserir_editar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/ui/turno_trabalho_form_page.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/ui/turno_trabalho_list_page.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/ui/turno_trabalho_visualizar_page.dart';

class TurnoDeTrabalhoModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      MfeModule(
        title: translation.titles.turnosDeTrabalho,
        section: 'PCP',
        controller: MfeController(),
        onPressed: () => Modular.to.pushNamed(NavigationRouter.turnosDeTrabalhosModule.path),
      ),
      child: (context, mfe) => NhidsLaunchpadSimpleCard(mfe: mfe),
    );
  }

  @override
  List<Module> get imports => [PcpModule()];

  @override
  void binds(Injector i) {
    i //Datasources
      ..addLazySingleton<RemoteTurnoTrabalhoDatasource>(RemoteTurnoTrabalhoDatasourceImpl.new)

      //Repositories
      ..addLazySingleton<TurnoTrabalhoRepository>(TurnoTrabalhoRepositoryImpl.new)

      //Usecases
      ..addLazySingleton<GetTurnoTrabalhoPorIdUsecase>(GetTurnoTrabalhoPorIdUsecaseImpl.new)
      ..addLazySingleton<GetTurnoTrabalhoRecenteUsecase>(GetTurnoTrabalhoRecenteUsecaseImpl.new)
      ..addLazySingleton<GetTurnosTrabalhosUsecase>(GetTurnosTrabalhosUsecaseImpl.new)
      ..addLazySingleton<InserirTurnoTrabalhoUsecase>(InserirTurnoTrabalhoUsecaseImpl.new)
      ..addLazySingleton<EditarTurnoTrabalhoUsecase>(EditarTurnoTrabalhoUsecaseImpl.new)
      ..addLazySingleton<DeletarTurnoTrabalhoUsecase>(DeletarTurnoTrabalhoUsecaseImpl.new)

      //Stores
      ..addLazySingleton(TurnoTrabalhoListStore.new)
      ..addLazySingleton(GetTurnoTrabalhoPorIdStore.new)
      ..add(InserirEditarTurnoTrabalhoStore.new)

      //Controllers
      ..addLazySingleton(TurnoTrabalhoFormController.new);
  }

  @override
  void routes(RouteManager r) {
    r //
      ..child(
        NavigationRouter.startModule.module,
        child: (context) => TurnoTrabalhoListPage(
          turnoTrabalhoListStore: context.read(),
          scaffoldController: context.read(),
          connectionStore: context.read(),
        ),
      )
      ..child(
        NavigationRouter.createModule.module,
        child: (context) => TurnoTrabalhoFormPage(
          inserirEditarTurnoTrabalhoStore: context.read(),
          turnoTrabalhoListStore: context.read(),
          turnoTrabalhoFormController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.updateModule.module,
        child: (context) => TurnoTrabalhoVisualizarPage(
          id: r.args.params['id'],
          inserirEditarTurnoTrabalhoStore: context.read(),
          turnoTrabalhoListStore: context.read(),
          getTurnoTrabalhoPorIdStore: context.read(),
          turnoTrabalhoFormController: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      );
  }
}
