import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/entities/turno_trabalho_entity.dart';

abstract class RemoteGetTurnoTrabalhoDatasource {
  Future<List<TurnoTrabalhoEntity>> call();
}
