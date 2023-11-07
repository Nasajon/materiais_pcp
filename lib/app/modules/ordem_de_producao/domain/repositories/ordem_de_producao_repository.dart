import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';

abstract interface class OrdemDeProducaoRepository {
  Future<List<OrdemDeProducaoAggregate>> getOrdens({String search = '', String ultimoId = ''});

  Future<OrdemDeProducaoAggregate> getOrdemDeProducaoPorId(String ordemDeProducaoId);

  Future<OrdemDeProducaoAggregate> inserir(OrdemDeProducaoAggregate ordemDeProducao);

  Future<bool> atualizar(OrdemDeProducaoAggregate ordemDeProducao);

  Future<bool> deletar(String ordemDeProducaoId);
}
