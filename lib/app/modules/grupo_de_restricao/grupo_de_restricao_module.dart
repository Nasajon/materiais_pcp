import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/repositories/grupo_de_restricao_repository.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/usecases/deletar_grupo_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_by_id_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_list_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/usecases/save_grupo_de_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/external/datasources/remote/grupo_de_restricao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/infra/datasources/remote/grupo_de_restricao_datasource.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/infra/repositories/grupo_de_restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/stores/grupo_de_restricao_form_store.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/stores/grupo_de_restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/ui/pages/grupo_de_restricao_form_page.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/ui/pages/grupo_de_restricao_list_page.dart';
import 'package:pcp_flutter/app/modules/pcp_module.dart';

class GrupoDeRestricaoModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      MfeModule(
        title: translation.titles.grupoDeRestricoes,
        section: 'PCP',
        controller: MfeController(),
        onPressed: () => Modular.to.pushNamed(NavigationRouter.gruposDeRestricoesModule.path),
      ),
      child: (context, mfe) => NhidsLaunchpadSimpleCard(mfe: mfe),
    );
  }

  @override
  List<Module> get imports => [PcpModule()];

  @override
  void binds(Injector i) {
    i //DataSources
      ..addLazySingleton<GrupoDeRestricaoDatasource>(GrupoDeRestricaoDatasourceImpl.new)

      //Repositories
      ..addLazySingleton<GrupoDeRestricaoRepository>(GrupoDeRestricaoRepositoryImpl.new)

      //UseCases
      ..addLazySingleton<GetGrupoDeRestricaoRecenteUsecase>(GetGrupoDeRestricaoRecenteUsecaseImpl.new)
      ..addLazySingleton<GetGrupoDeRestricaoListUsecase>(GetGrupoDeRestricaoListUsecaseImpl.new)
      ..addLazySingleton<GetGrupoDeRestricaoByIdUsecase>(GetGrupoDeRestricaoByIdUsecaseImpl.new)
      ..addLazySingleton<SaveGrupoDeRestricaoUsecase>(SaveGrupoDeRestricaoUsecaseImpl.new)
      ..addLazySingleton<DeletarGrupoDeRestricaoUsecase>(DeletarGrupoDeRestricaoUsecaseImpl.new)

      //Stores
      ..addLazySingleton(GrupoDeRestricaoListStore.new)
      ..add(GrupoDeRestricaoFormStore.new)

      //Controller
      ..addLazySingleton(GrupoDeRestricaoController.new);
  }

  @override
  void routes(RouteManager r) {
    r //
      ..child(
        NavigationRouter.startModule.module,
        child: (context) => GrupoDeRestricaoListPage(
          grupoDeRestricaoStore: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.createModule.module,
        child: (context) => GrupoDeRestricaoFormPage(
          grupoDeRestricaoFormStore: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
          grupoDeRestricaoController: context.read(),
        ),
      )
      ..child(
        NavigationRouter.updateModule.module,
        child: (context) => GrupoDeRestricaoFormPage(
          id: r.args.params['id'],
          grupoDeRestricaoFormStore: context.read(),
          connectionStore: context.read(),
          scaffoldController: context.read(),
          grupoDeRestricaoController: context.read(),
        ),
      );
  }
}
