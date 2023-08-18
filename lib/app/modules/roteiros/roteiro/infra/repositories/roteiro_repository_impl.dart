import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_roteiro_datasource.dart';

class RoteiroRepositoryImpl implements RoteiroRepository {
  final RemoteRoteiroDatasource _remoteRoteiroDatasource;

  const RoteiroRepositoryImpl(this._remoteRoteiroDatasource);

  @override
  Future<List<RoteiroEntity>> getRoteiro(String search) {
    return _remoteRoteiroDatasource.getRoteiro(search);
  }

  @override
  Future<List<RoteiroEntity>> getRoteiroRecente() {
    return _remoteRoteiroDatasource.getRoteiroRecente();
  }

  @override
  Future<RoteiroAggregate> getRoteiroPorId(String roteiroId) {
    return _remoteRoteiroDatasource.getRoteiroPeloId(roteiroId);
  }

  @override
  Future<bool> editarRoteiro(RoteiroAggregate roteiro) {
    return _remoteRoteiroDatasource.editarRoteiro(roteiro);
  }

  @override
  Future<String> inserirRoteiro(RoteiroAggregate roteiro) {
    return _remoteRoteiroDatasource.inserirRoteiro(roteiro);
  }

  @override
  Future<bool> deletarRoteiro(String roteiroId) {
    return _remoteRoteiroDatasource.deletarRoteiro(roteiroId);
  }
}
