import 'package:pcp_flutter/app/modules/recursos/recurso/domain/repositories/recurso_repository.dart';

abstract class DeleteRecursoUsecase {
  Future<bool> call(String id);
}

class DeleteRecursoUsecaseImpl implements DeleteRecursoUsecase {
  final RecursoRepository _recursoRepository;

  const DeleteRecursoUsecaseImpl(this._recursoRepository);

  @override
  Future<bool> call(String id) {
    if (id.isEmpty) {
      // TODO: Adicionar mensagem de erro
    }

    return _recursoRepository.deleteItem(id);
  }
}
