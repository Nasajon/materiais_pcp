import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';

abstract class GetRecursoPorGrupoRepository {
  Future<List<RecursoAggregate>> call(String idGrupoDeRecurso);
}
