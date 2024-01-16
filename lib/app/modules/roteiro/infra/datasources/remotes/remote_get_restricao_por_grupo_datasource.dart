import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/restricao_aggregate.dart';

abstract class RemoteGetRestricaoPorGrupoDatasource {
  Future<List<RestricaoAggregate>> call(String grupoDeRestricaoId);
}
