import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:nsj_flutter_login/nsj_login.dart';
import 'package:pcp_flutter/app/modules/presenter/widgets/card_widget.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/grupo_de_recurso_module.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/recurso_module.dart';

class RecursosModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [
      ...GrupoDeRecursoModule.getCards(context),
      ...RecursoModule.getCards(context),
    ];
  }

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: RecursoModule(), guards: [EstabelecimentoGuard()]),
        ModuleRoute('/grupo-de-recursos', module: GrupoDeRecursoModule(), guards: [EstabelecimentoGuard()]),
      ];
}
