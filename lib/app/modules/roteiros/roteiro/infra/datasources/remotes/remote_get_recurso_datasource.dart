import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';

abstract class RemoteGetRecursoDatasource {
  Future<List<RecursoAggregate>> call(String idGrupoDeRecurso);
}
