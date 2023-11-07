import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_ordem_de_producao_datasource.dart';

class OrdemDeProducaoRepositoryImpl implements OrdemDeProducaoRepository {
  final RemoteOrdemDeProducaoDatasource _remoteOrdemDeProducaoDatasource;

  const OrdemDeProducaoRepositoryImpl(this._remoteOrdemDeProducaoDatasource);

  @override
  Future<List<OrdemDeProducaoAggregate>> getOrdens({String search = '', String ultimoId = ''}) {
    return _remoteOrdemDeProducaoDatasource.getOrdens(search: search, ultimoId: ultimoId);
  }

  @override
  Future<OrdemDeProducaoAggregate> getOrdemDeProducaoPorId(String ordemDeProducaoId) {
    return _remoteOrdemDeProducaoDatasource.getOrdemDeProducaoPorId(ordemDeProducaoId);
  }

  @override
  Future<OrdemDeProducaoAggregate> inserir(OrdemDeProducaoAggregate ordemDeProducao) {
    return _remoteOrdemDeProducaoDatasource.inserir(ordemDeProducao);
  }

  @override
  Future<bool> atualizar(OrdemDeProducaoAggregate ordemDeProducao) {
    return _remoteOrdemDeProducaoDatasource.atualizar(ordemDeProducao);
  }

  @override
  Future<bool> deletar(String ordemDeProducaoId) {
    return _remoteOrdemDeProducaoDatasource.deletar(ordemDeProducaoId);
  }
}
