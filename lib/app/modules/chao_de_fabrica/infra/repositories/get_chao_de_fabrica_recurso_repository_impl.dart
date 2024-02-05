import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/get_chao_de_fabrica_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_get_chao_de_fabrica_recurso_datasource.dart';

class GetChaoDeFabricaRecursoRepositoryImpl implements GetChaoDeFabricaRecursoRepository {
  final RemoteGetChaoDeFabricaRecursoDatasource _remoteRecursoDatasource;

  const GetChaoDeFabricaRecursoRepositoryImpl({
    required RemoteGetChaoDeFabricaRecursoDatasource remoteRecursoDatasource,
  }) : _remoteRecursoDatasource = remoteRecursoDatasource;

  @override
  Future<List<ChaoDeFabricaRecursoEntity>> call({required String search, String? ultimoRecursoId}) {
    return _remoteRecursoDatasource(
      search: search,
      ultimoRecursoId: ultimoRecursoId,
    );
  }
}
