import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/domain/repositories/get_turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/infra/datasources/remotes/remote_get_turno_trabalho_datasource.dart';

class GetTurnoTrabalhoRepositoryImpl implements GetTurnoTrabalhoRepository {
  final RemoteGetTurnoTrabalhoDatasource _remoteGetTurnoTrabalhoDatasource;

  const GetTurnoTrabalhoRepositoryImpl(this._remoteGetTurnoTrabalhoDatasource);

  @override
  Future<List<TurnoTrabalhoEntity>> call() {
    return _remoteGetTurnoTrabalhoDatasource();
  }
}
