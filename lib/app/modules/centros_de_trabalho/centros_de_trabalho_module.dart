import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/centro_de_trabalho_module.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/turno_de_trabalho_module.dart';
import 'package:pcp_flutter/app/modules/presenter/presenter.dart';

class CentrosDeTrabalhoModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [
      ...CentroDeTrabalhoModule.getCards(context),
      ...TurnoDeTrabalhoModule.getCards(context),
    ];
  }

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: CentroDeTrabalhoModule()),
        ModuleRoute('/turnos', module: TurnoDeTrabalhoModule()),
      ];
}
