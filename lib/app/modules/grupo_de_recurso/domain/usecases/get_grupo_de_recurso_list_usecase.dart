import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';

import '../repositories/grupo_de_recursos_repository.dart';

abstract class GetGrupoDeRecursoListUsecase {
  Future<List<GrupoDeRecurso>> call([String? search]);
}

class GetGrupoDeRecursoListUsecaseImpl implements GetGrupoDeRecursoListUsecase {
  final GrupoDeRecursosRepository _repository;

  GetGrupoDeRecursoListUsecaseImpl(this._repository);

  @override
  Future<List<GrupoDeRecurso>> call([String? search]) async {
    return _repository.getList(search);
  }
}
