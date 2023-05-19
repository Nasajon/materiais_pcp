import '../entities/recurso.dart';
import '../repositories/recurso_repository.dart';

abstract class SaveRecursoUsecase {
  Future<Recurso> call(Recurso recurso);
}

class SaveRecursoUsecaseImpl implements SaveRecursoUsecase {
  final RecursoRepository repository;

  SaveRecursoUsecaseImpl(this.repository);

  @override
  Future<Recurso> call(Recurso recurso) {
    return recurso.id != null && recurso.id!.isNotEmpty
        ? repository.updateItem(recurso)
        : repository.insertItem(recurso);
  }
}
