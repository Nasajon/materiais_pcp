import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

import '../errors/grupo_de_recursos_failures.dart';
import '../repositories/grupo_de_recursos_repository.dart';

abstract class GetGrupoDeRecursoByIdUsecase {
  Future<GrupoDeRecurso> call(String id);
}

class GetGrupoDeRecursoByIdUsecaseImpl implements GetGrupoDeRecursoByIdUsecase {
  final GrupoDeRecursosRepository _repository;

  GetGrupoDeRecursoByIdUsecaseImpl(this._repository);

  @override
  Future<GrupoDeRecurso> call(String id) {
    if (id.isEmpty) {
      return Future.error(GrupoDeRecursosInvalidIdError());
    }

    return _repository.getItem(id);
  }
}
