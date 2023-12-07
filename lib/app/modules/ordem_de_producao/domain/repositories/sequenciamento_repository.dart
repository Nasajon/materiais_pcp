import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/dto/sequenciamento_dto.dart';

abstract interface class SequenciamentoRepository {
  Future<SequenciamentoAggregate> gerarSequencimaneto(SequenciamentoDTO sequenciamento);
  Future<bool> sequenciarOrdemDeProducao(SequenciamentoAggregate sequenciamento);
}
