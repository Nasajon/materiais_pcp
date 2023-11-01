import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_roteiro_datasource.dart';

class GetRoteiroRepositoryImpl implements GetRoteiroRepository {
  final RemoteGetRoteiroDatasource _getRoteiroDatasource;

  const GetRoteiroRepositoryImpl(this._getRoteiroDatasource);

  @override
  Future<List<RoteiroEntity>> call(String produtoId, {String search = '', String ultimoId = ''}) {
    return _getRoteiroDatasource(produtoId, search: search, ultimoId: ultimoId);
  }
}
