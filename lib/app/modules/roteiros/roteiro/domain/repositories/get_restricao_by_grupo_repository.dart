import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';

abstract class GetRestricaoByGrupoRepository {
  Future<List<RestricaoAggregate>> call(String grupoDeRestricaoId);
}
