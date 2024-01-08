import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/turno_de_trabalho_entity.dart';

abstract interface class GetTurnoDeTrabalhoRepository {
  Future<List<TurnoDeTrabalhoEntity>> call(String centroDeTrabalhoId, {required String search, String? ultimoTurnoTrabalhoId});
}
