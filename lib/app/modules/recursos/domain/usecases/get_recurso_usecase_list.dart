import '../entities/recurso.dart';
import '../repositories/recurso_repository.dart';

abstract class GetRecursoListUsecase {
  Future<List<Recurso>> call([String? search]);
}

class GetRecursoListUsecaseImpl implements GetRecursoListUsecase {
  final RecursoRepository repository;

  GetRecursoListUsecaseImpl(this.repository);

  @override
  Future<List<Recurso>> call([String? search]) async {
    return repository.getList(search);
  }
}
