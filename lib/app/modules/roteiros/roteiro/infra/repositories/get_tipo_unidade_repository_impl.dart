import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_unidade_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_unidade_datasource.dart';

class GetUnidadeRepositoryImpl implements GetUnidadeRepository {
  final RemoteGetUnidadeDatasource _remoteGetUnidadeDatasource;

  const GetUnidadeRepositoryImpl(this._remoteGetUnidadeDatasource);

  @override
  Future<List<UnidadeEntity>> call(String search) {
    return _remoteGetUnidadeDatasource(search);
  }
}
