import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/repositories/get_grupo_de_recurso_repository.dart';

abstract class GetGrupoDeRecursoUsecase {
  Future<List<GrupoDeRecurso>> call({
    required String search,
    String? ultimoGrupoDeRecursoId,
  });
}

class GetGrupoDeRecursoUsecaseImpl implements GetGrupoDeRecursoUsecase {
  final GetGrupoDeRecursoRepository _getGrupoDeRecursoRepository;

  GetGrupoDeRecursoUsecaseImpl(this._getGrupoDeRecursoRepository);

  @override
  Future<List<GrupoDeRecurso>> call({
    required String search,
    String? ultimoGrupoDeRecursoId,
  }) {
    return _getGrupoDeRecursoRepository.getList(search: search, ultimoGrupoDeRecursoId: ultimoGrupoDeRecursoId);
  }
}
