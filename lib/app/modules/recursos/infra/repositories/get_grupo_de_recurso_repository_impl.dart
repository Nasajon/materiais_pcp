import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/repositories/get_grupo_de_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/datasources/remote/get_grupo_de_recurso_datasource.dart';

class GetGrupoDeRecursoRepositoryImpl implements GetGrupoDeRecursoRepository {
  final GetGrupoDeRecursoDatasource _getGrupoDeRecursoDatasource;

  GetGrupoDeRecursoRepositoryImpl(this._getGrupoDeRecursoDatasource);

  @override
  Future<List<RecursoGrupoDeRecurso>> getList({
    required String search,
    String? ultimoGrupoDeRecursoId,
  }) {
    return _getGrupoDeRecursoDatasource.getList(search: search, ultimoGrupoDeRecursoId: ultimoGrupoDeRecursoId);
  }
}
