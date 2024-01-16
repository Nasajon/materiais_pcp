import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/unidade_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/datasources/remotes/remote_unidade_datasource.dart';

class UnidadeRepositoryImpl implements UnidadeRepository {
  final RemoteUnidadeDatasource remoteUnidadeDatasource;

  UnidadeRepositoryImpl(this.remoteUnidadeDatasource);

  @override
  Future<List<UnidadeEntity>> getTodasUnidades(String search) {
    return remoteUnidadeDatasource.getTodasUnidades(search);
  }

  @override
  Future<Map<String, UnidadeEntity>> getTodasUnidadesPorIds(List<String> ids) {
    return remoteUnidadeDatasource.getTodasUnidadesPorIds(ids);
  }
}
