import 'package:design_system/design_system.dart' hide CardWidget;
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/base_url.dart';
import 'package:pcp_flutter/app/core/constants/local_db_key.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/stores/reducers/internet_connection_reducer.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/centro_de_trabalho_module.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/chao_de_fabrica_module.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/ficha_tecnica_module.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/grupo_de_recurso_module.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/grupo_de_restricao_module.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/ordem_de_producao_module.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso_module.dart';
import 'package:pcp_flutter/app/modules/restricao/restricao_module.dart';
import 'package:pcp_flutter/app/modules/roteiro/roteiro_module.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/turno_de_trabalho_module.dart';

class PcpModule extends NasajonModule {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void exportedBinds(Injector i) {
    i //
      ..addLazySingleton<IClientService>(() => DioClientServiceImpl(BaseUrl.url()))
      ..addLazySingleton<Database>(() => HiveDatabaseService(boxName: LocalDBKeys.boxKey))
      ..addSingleton(() => CustomScaffoldController())
      ..addSingleton(() => InternetConnectionReducer(connectionStore: i(), scaffoldController: i()));
  }

  @override
  void routes(RouteManager r) {
    r //
      ..module(NavigationRouter.chaoDeFabricaModule.module, module: ChaoDeFabricaModule())
      ..module(NavigationRouter.fichasTecnicasModule.module, module: FichaTecnicaModule())
      ..module(NavigationRouter.roteirosModule.module, module: RoteiroModule())
      ..module(NavigationRouter.centrosDeTrabalhosModule.module, module: CentroDeTrabalhoModule())
      ..module(NavigationRouter.turnosDeTrabalhosModule.module, module: TurnoDeTrabalhoModule())
      ..module(NavigationRouter.recursosModule.module, module: RecursoModule())
      ..module(NavigationRouter.gruposDeRecursosModule.module, module: GrupoDeRecursoModule())
      ..module(NavigationRouter.restricoesModule.module, module: RestricaoModule())
      ..module(NavigationRouter.gruposDeRestricoesModule.module, module: GrupoDeRestricaoModule())
      ..module(NavigationRouter.ordensDeProducoesModule.module, module: OrdemDeProducaoModule());
  }
}
