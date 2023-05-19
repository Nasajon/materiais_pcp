import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

import '../repositories/grupo_de_recursos_repository.dart';

abstract class SaveGrupoDeRecursoUsecase {
  Future<GrupoDeRecurso> call(GrupoDeRecurso grupoDeRecurso);
}

class SaveGrupoDeRecursoUsecaseImpl implements SaveGrupoDeRecursoUsecase {
  final GrupoDeRecursosRepository _repository;

  SaveGrupoDeRecursoUsecaseImpl(this._repository);

  @override
  Future<GrupoDeRecurso> call(GrupoDeRecurso grupoDeRecurso) {
    if (grupoDeRecurso.id != null && grupoDeRecurso.id!.isNotEmpty) {
      return _repository.updateItem(grupoDeRecurso);
    }

    return _repository.insertItem(grupoDeRecurso);
  }
}
