import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/dto/sequenciamento_dto.dart';

abstract interface class RemoteSequenciamentoDatasource {
  Future<SequenciamentoAggregate> gerarSequencimaneto(SequenciamentoDTO sequenciamento);
}
