import '../entities/grupo_de_recurso.dart';
import '../repositories/grupo_de_recursos_repository.dart';

abstract class SaveGrupoDeRecursoUsecase {
  Future<GrupoDeRecurso> call(GrupoDeRecurso grupoDeRecurso);
}

class SaveGrupoDeRecursoUsecaseImpl implements SaveGrupoDeRecursoUsecase {
  final GrupoDeRecursosRepository _repository;

  SaveGrupoDeRecursoUsecaseImpl(this._repository);

  @override
  Future<GrupoDeRecurso> call(GrupoDeRecurso grupoDeRecurso) {
    return grupoDeRecurso.id != null && grupoDeRecurso.id!.isNotEmpty
        ? _repository.updateItem(grupoDeRecurso)
        : _repository.insertItem(grupoDeRecurso);
  }
}
