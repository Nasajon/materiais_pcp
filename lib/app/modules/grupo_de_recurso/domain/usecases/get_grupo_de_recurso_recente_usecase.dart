import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';

import '../repositories/grupo_de_recursos_repository.dart';

abstract class GetGrupoDeRecursoRecenteUsecase {
  Future<List<GrupoDeRecurso>> call();
}

class GetGrupoDeRecursoRecenteUsecaseImpl implements GetGrupoDeRecursoRecenteUsecase {
  final GrupoDeRecursosRepository _repository;

  GetGrupoDeRecursoRecenteUsecaseImpl(this._repository);

  @override
  Future<List<GrupoDeRecurso>> call() async {
    return _repository.getGrupoDeRecursoRecente();
  }
}
