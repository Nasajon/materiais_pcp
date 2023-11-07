import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/repositories/restricao_repository.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/infra/datasources/remote/remote_restricao_datasource.dart';

class RestricaoRepositoryImpl implements RestricaoRepository {
  final RemoteRestricaoDatasource _remoteRestricaoDatasource;

  const RestricaoRepositoryImpl(this._remoteRestricaoDatasource);

  @override
  Future<List<RestricaoAggregate>> getRestricaoRecente() {
    return _remoteRestricaoDatasource.getRestricaoRecente();
  }

  @override
  Future<List<RestricaoAggregate>> getList([String? search]) {
    return _remoteRestricaoDatasource.getList(search);
  }

  @override
  Future<RestricaoAggregate> getRestricaoPorId(String id) {
    return _remoteRestricaoDatasource.getRestricaoPorId(id);
  }

  @override
  Future<RestricaoAggregate> insert(RestricaoAggregate restricao) {
    return _remoteRestricaoDatasource.insert(restricao);
  }

  @override
  Future<bool> update(RestricaoAggregate restricao) {
    return _remoteRestricaoDatasource.update(restricao);
  }

  @override
  Future<bool> delete(String id) {
    return _remoteRestricaoDatasource.delete(id);
  }
}
