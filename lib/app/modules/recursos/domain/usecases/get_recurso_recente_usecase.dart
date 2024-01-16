import '../entities/recurso.dart';
import '../repositories/recurso_repository.dart';

abstract class GetRecursoRecenteUsecase {
  Future<List<Recurso>> call();
}

class GetRecursoRecenteUsecaseImpl implements GetRecursoRecenteUsecase {
  final RecursoRepository repository;

  GetRecursoRecenteUsecaseImpl(this.repository);

  @override
  Future<List<Recurso>> call() async {
    return repository.getRecursoRecente();
  }
}
