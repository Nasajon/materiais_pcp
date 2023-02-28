import 'package:flutter/cupertino.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:nsj_flutter_login/nsj_login.dart';

import 'grupo_de_recurso/grupo_de_recurso_module.dart';
import 'presenter/widgets/card_widget.dart';
import 'recurso/recurso_module.dart';

class PcpModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [
      ...GrupoDeRecursoModule.getCards(context),
      ...RecursoModule.getCards(context),
    ];
  }

  @override
  List<Module> get imports => const [];

  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/grupo-de-recursos',
            module: GrupoDeRecursoModule(), guards: [EstabelecimentoGuard()]),
        ModuleRoute('/recursos',
            module: RecursoModule(), guards: [EstabelecimentoGuard()]),
      ];
}
