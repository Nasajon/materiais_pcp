import 'package:pcp_flutter/app/modules/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_centro_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_centro_de_trabalho_datasource.dart';

class GetCentroDeTrabalhoRepositoryImpl implements GetCentroDeTrabalhoRepository {
  final RemoteGetCentroDeTrabalhoDatasource _remoteGetCentroDeTrabalhoDatasource;

  const GetCentroDeTrabalhoRepositoryImpl(this._remoteGetCentroDeTrabalhoDatasource);

  @override
  Future<List<CentroDeTrabalhoEntity>> call(String search) {
    return _remoteGetCentroDeTrabalhoDatasource(search);
  }
}
