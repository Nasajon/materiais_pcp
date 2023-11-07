import 'package:design_system/design_system.dart' hide CardWidget;
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/base_url.dart';
import 'package:pcp_flutter/app/core/constants/local_db_key.dart';
import 'package:pcp_flutter/app/core/stores/reducers/internet_connection_reducer.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centros_de_trabalho_module.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/ficha_tecnica_module.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/ordem_de_producao_module.dart';
import 'package:pcp_flutter/app/modules/recursos/recursos_module.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricoes_module.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/roteiro_module.dart';

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
        ModuleRoute('/roteiro', module: RoteiroModule()),
        ModuleRoute('/ficha-tecnica', module: FichaTecnicaModule()),
        ModuleRoute('/restricoes', module: RestricoesModule()),
        ModuleRoute('/centro-de-trabalho', module: CentrosDeTrabalhoModule()),
        ModuleRoute('/recursos', module: RecursosModule()),
        ModuleRoute('/ordem-de-producao', module: OrdemDeProducaoModule()),
      ];
}
