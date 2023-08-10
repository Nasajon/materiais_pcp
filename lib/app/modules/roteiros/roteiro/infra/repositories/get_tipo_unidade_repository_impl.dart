import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/tipo_unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_tipo_unidade_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_tipo_unidade_datasource.dart';

class GetTipoUnidadeRepositoryImpl implements GetTipoUnidadeRepository {
  final RemoteGetTipoUnidadeDatasource _remoteGetTipoUnidadeDatasource;

  const GetTipoUnidadeRepositoryImpl(this._remoteGetTipoUnidadeDatasource);

  @override
  Future<List<TipoUnidadeEntity>> call(String search) {
    return _remoteGetTipoUnidadeDatasource(search);
  }
}
