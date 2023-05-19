import '../entities/recurso.dart';
import '../errors/recurso_failures.dart';
import '../repositories/recurso_repository.dart';

abstract class GetRecursoByIdUsecase {
  Future<Recurso> call(String id);
}

class GetRecursoByIdUsecaseImpl implements GetRecursoByIdUsecase {
  final RecursoRepository repository;

  GetRecursoByIdUsecaseImpl(this.repository);

  @override
  Future<Recurso> call(String id) {
    if (id.isEmpty) {
      return Future.error(RecursoInvalidIdError());
    }

    return repository.getItem(id);
  }
}
