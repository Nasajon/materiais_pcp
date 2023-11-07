import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:nsj_flutter_login/nsj_login.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/grupo_de_restricao_module.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/restricao_module.dart';

class RestricoesModule extends NasajonModule {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: RestricaoModule(), guards: [EstabelecimentoGuard()]),
        ModuleRoute('/grupo-de-restricao', module: GrupoDeRestricaoModule(), guards: [EstabelecimentoGuard()]),
      ];
}
