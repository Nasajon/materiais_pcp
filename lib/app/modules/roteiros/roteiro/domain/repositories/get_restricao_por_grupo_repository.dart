import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';

abstract class GetRestricaoPorGrupoRepository {
  Future<List<RestricaoAggregate>> call(String grupoDeRestricaoId);
}
