import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/centro_de_trabalho_module.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/turno_de_trabalho_module.dart';

class CentrosDeTrabalhoModule extends NasajonModule {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: CentroDeTrabalhoModule()),
        ModuleRoute('/turnos', module: TurnoDeTrabalhoModule()),
      ];
}
