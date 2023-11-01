import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_cliente_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_cliente_datasource.dart';

class GetClienteRepositoryImpl implements GetClienteRepository {
  final RemoteGetClienteDatasource _remoteGetClienteDatasource;

  const GetClienteRepositoryImpl(this._remoteGetClienteDatasource);

  @override
  Future<List<ClienteEntity>> call({String search = '', String ultimoId = ''}) {
    return _remoteGetClienteDatasource(search: search, ultimoId: ultimoId);
  }
}
