import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_grupo_de_recurso_repository.dart';

abstract class GetGrupoDeRecursoUsecase {
  Future<List<GrupoDeRecursoEntity>> call(String search);
}

class GetGrupoDeRecursoUsecaseImpl implements GetGrupoDeRecursoUsecase {
  final GetGrupoDeRecursoRepository _getGrupoDeRecursoRepository;

  const GetGrupoDeRecursoUsecaseImpl(this._getGrupoDeRecursoRepository);

  @override
  Future<List<GrupoDeRecursoEntity>> call(String search) {
    return _getGrupoDeRecursoRepository(search);
  }
}
