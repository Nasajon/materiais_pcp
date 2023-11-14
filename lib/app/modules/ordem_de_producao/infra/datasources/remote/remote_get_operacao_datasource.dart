import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';

abstract interface class RemoteGetOperacaoDatasource {
  Future<List<OperacaoAggregate>> call(String roteiroId);
}
