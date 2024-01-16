import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/repositories/grupo_de_recursos_repository.dart';

abstract class DeleteGrupoDeRecursoUsecase {
  Future<bool> call(String id);
}

class DeleteGrupoDeRecursoUsecaseImpl implements DeleteGrupoDeRecursoUsecase {
  final GrupoDeRecursosRepository _grupoDeRecursosRepository;

  const DeleteGrupoDeRecursoUsecaseImpl(this._grupoDeRecursosRepository);

  @override
  Future<bool> call(String id) {
    if (id.isEmpty) {
      // TODO: mensagem de erro
    }

    return _grupoDeRecursosRepository.deleteItem(id);
  }
}
