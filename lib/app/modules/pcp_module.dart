import 'package:design_system/design_system.dart' hide CardWidget;
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/base_url.dart';
import 'package:pcp_flutter/app/core/constants/local_db_key.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/stores/reducers/internet_connection_reducer.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/centro_de_trabalho_module.dart';
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
  List<Bind> get binds => [
        Bind.lazySingleton((i) => DioClientServiceImpl(BaseUrl.url())),
        Bind.lazySingleton((i) => HiveDatabaseService(boxName: LocalDBKeys.boxKey)),
        Bind.singleton((i) => CustomScaffoldController()),
        Bind.singleton((i) => InternetConnectionReducer(connectionStore: i(), scaffoldController: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(NavigationRouter.fichasTecnicasModule.module, module: FichaTecnicaModule()),
        ModuleRoute(NavigationRouter.roteirosModule.module, module: RoteiroModule()),
        ModuleRoute(NavigationRouter.centrosDeTrabalhosModule.module, module: CentroDeTrabalhoModule()),
        ModuleRoute(NavigationRouter.turnosDeTrabalhosModule.module, module: TurnoDeTrabalhoModule()),
        ModuleRoute(NavigationRouter.recursosModule.module, module: RecursoModule()),
        ModuleRoute(NavigationRouter.gruposDeRecursosModule.module, module: GrupoDeRecursoModule()),
        ModuleRoute(NavigationRouter.restricoesModule.module, module: RestricaoModule()),
        ModuleRoute(NavigationRouter.gruposDeRestricoesModule.module, module: GrupoDeRestricaoModule()),
        ModuleRoute(NavigationRouter.ordensDeProducoesModule.module, module: OrdemDeProducaoModule()),
      ];
}
