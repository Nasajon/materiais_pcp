import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_recurso_por_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_recurso_por_grupo_datasource.dart';

class GetRecursoPorGrupoRepositoryImpl implements GetRecursoPorGrupoRepository {
  final RemoteGetRecursoPorGrupoDatasource _remoteGetRecursoPorGrupoDatasource;

  const GetRecursoPorGrupoRepositoryImpl(this._remoteGetRecursoPorGrupoDatasource);

  @override
  Future<List<RecursoAggregate>> call(String idGrupoDeRecurso) {
    return _remoteGetRecursoPorGrupoDatasource(idGrupoDeRecurso);
  }
}
