import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_ficha_tecnica_datasource.dart';

class GetFichaTecnicaRepositoryImpl implements GetFichaTecnicaRepository {
  final RemoteGetFichaTecnicaDatasource _remoteGetFichaTecnicaDatasource;

  const GetFichaTecnicaRepositoryImpl(this._remoteGetFichaTecnicaDatasource);

  @override
  Future<List<FichaTecnicaEntity>> call(String search) {
    return _remoteGetFichaTecnicaDatasource(search);
  }
}
