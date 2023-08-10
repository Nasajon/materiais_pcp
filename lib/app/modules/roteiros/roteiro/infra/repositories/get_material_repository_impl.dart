import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_material_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_material_datasource.dart';

class GetMaterialRepositoryImpl implements GetMaterialRepository {
  final RemoteGetMaterialDatasource _remoteGetMaterialDatasource;

  const GetMaterialRepositoryImpl(this._remoteGetMaterialDatasource);

  @override
  Future<List<MaterialEntity>> call(String idFichaTecnica) {
    return _remoteGetMaterialDatasource(idFichaTecnica);
  }
}
