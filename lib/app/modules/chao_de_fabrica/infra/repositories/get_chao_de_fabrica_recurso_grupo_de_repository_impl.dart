import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/get_chao_de_fabrica_grupo_de_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_get_chao_de_fabrica_grupo_de_recurso_datasource.dart';

class GetChaoDeFabricaGrupoDeRecursoRepositoryImpl implements GetChaoDeFabricaGrupoDeRecursoRepository {
  final RemoteGetChaoDeFabricaGrupoDeRecursoDatasource _remoteGrupoDeRecursoDatasource;

  const GetChaoDeFabricaGrupoDeRecursoRepositoryImpl({
    required RemoteGetChaoDeFabricaGrupoDeRecursoDatasource remoteGrupoDeRecursoDatasource,
  }) : _remoteGrupoDeRecursoDatasource = remoteGrupoDeRecursoDatasource;

  @override
  Future<List<ChaoDeFabricaGrupoDeRecursoEntity>> call({String? ultimoGrupoDeRecursoId}) {
    return _remoteGrupoDeRecursoDatasource(
      ultimoGrupoDeRecursoId: ultimoGrupoDeRecursoId,
    );
  }
}
