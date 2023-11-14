import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:nsj_flutter_login/nsj_login.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/grupo_de_recurso_module.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/recurso_module.dart';

class RecursosModule extends NasajonModule {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: RecursoModule(), guards: [EstabelecimentoGuard()]),
        ModuleRoute('/grupo-de-recursos', module: GrupoDeRecursoModule(), guards: [EstabelecimentoGuard()]),
      ];
}
