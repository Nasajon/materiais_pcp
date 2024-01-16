import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_grupo_de_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_grupo_de_recurso_datasource.dart';

class GetGrupoDeRecursoRepositoryImpl implements GetGrupoDeRecursoRepository {
  final RemoteGetGrupoDeRecursoDatasource _remoteGetGrupoDeRecursoDatasource;

  const GetGrupoDeRecursoRepositoryImpl(this._remoteGetGrupoDeRecursoDatasource);

  @override
  Future<List<GrupoDeRecursoEntity>> call(search) {
    return _remoteGetGrupoDeRecursoDatasource(search);
  }
}
