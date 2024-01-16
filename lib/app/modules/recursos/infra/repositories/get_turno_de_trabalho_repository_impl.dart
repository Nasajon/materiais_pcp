import 'package:pcp_flutter/app/modules/recursos/domain/entities/turno_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/repositories/get_turno_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/datasources/remote/remote_get_turno_de_trabalho_datasource.dart';

class GetTurnoDeTrabalhoRepositoryImpl implements GetTurnoDeTrabalhoRepository {
  final RemoteGetTurnoDeTrabalhoDatasource _getTurnoDeTrabalhoDatasource;

  const GetTurnoDeTrabalhoRepositoryImpl(this._getTurnoDeTrabalhoDatasource);

  @override
  Future<List<TurnoDeTrabalhoEntity>> call(String centroDeTrabalhoId, {required String search, String? ultimoTurnoTrabalhoId}) {
    return _getTurnoDeTrabalhoDatasource(centroDeTrabalhoId, search: search, ultimoTurnoTrabalhoId: ultimoTurnoTrabalhoId);
  }
}
