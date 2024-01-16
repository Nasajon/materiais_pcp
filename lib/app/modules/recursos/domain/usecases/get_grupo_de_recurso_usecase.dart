import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/repositories/get_grupo_de_recurso_repository.dart';

abstract class GetGrupoDeRecursoUsecase {
  Future<List<RecursoGrupoDeRecurso>> call({
    required String search,
    String? ultimoGrupoDeRecursoId,
  });
}

class GetGrupoDeRecursoUsecaseImpl implements GetGrupoDeRecursoUsecase {
  final GetGrupoDeRecursoRepository _getGrupoDeRecursoRepository;

  GetGrupoDeRecursoUsecaseImpl(this._getGrupoDeRecursoRepository);

  @override
  Future<List<RecursoGrupoDeRecurso>> call({
    required String search,
    String? ultimoGrupoDeRecursoId,
  }) {
    return _getGrupoDeRecursoRepository.getList(search: search, ultimoGrupoDeRecursoId: ultimoGrupoDeRecursoId);
  }
}
