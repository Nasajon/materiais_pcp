import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_recurso_datasource.dart';

class GetRecursoRepositoryImpl implements GetRecursoRepository {
  final RemoteGetRecursoDatasource _remoteGetRecursoDatasource;

  const GetRecursoRepositoryImpl(this._remoteGetRecursoDatasource);

  @override
  Future<List<RecursoAggregate>> call(String idGrupoDeRecurso) {
    return _remoteGetRecursoDatasource(idGrupoDeRecurso);
  }
}
