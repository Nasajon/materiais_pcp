import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';

abstract class RemoteGetRestricaoByGrupoDatasource {
  Future<List<RestricaoAggregate>> call(String grupoDeRestricaoId);
}
