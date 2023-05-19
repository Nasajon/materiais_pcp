import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/repositories/get_grupo_de_recurso_repository.dart';

abstract class GetGrupoDeRecursoUsecase {
  Future<List<GrupoDeRecurso>> call();
}

class GetGrupoDeRecursoUsecaseImpl implements GetGrupoDeRecursoUsecase {
  final GetGrupoDeRecursoRepository _getGrupoDeRecursoRepository;

  GetGrupoDeRecursoUsecaseImpl(this._getGrupoDeRecursoRepository);

  @override
  Future<List<GrupoDeRecurso>> call() {
    return _getGrupoDeRecursoRepository.getList();
  }
}
