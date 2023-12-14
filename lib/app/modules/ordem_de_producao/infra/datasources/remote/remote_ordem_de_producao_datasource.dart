import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';

abstract interface class RemoteOrdemDeProducaoDatasource {
  Future<List<OrdemDeProducaoAggregate>> getOrdens({String search = '', String ultimoId = '', String? status});

  Future<OrdemDeProducaoAggregate> getOrdemDeProducaoPorId(String ordemDeProducaoId);

  Future<bool> aprovarOrdemDeProducao(String ordemDeProducaoId);

  Future<OrdemDeProducaoAggregate> inserir(OrdemDeProducaoAggregate ordemDeProducao);

  Future<bool> atualizar(OrdemDeProducaoAggregate ordemDeProducao);

  Future<bool> deletar(String ordemDeProducaoId);
}
