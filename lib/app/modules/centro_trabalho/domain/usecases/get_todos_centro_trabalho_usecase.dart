import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';

abstract class GetTodosCentroTrabalhoUsecase {
  Future<List<CentroTrabalhoAggregate>> call(String search);
}

class GetTodosCentroTrabalhoUsecaseImpl implements GetTodosCentroTrabalhoUsecase {
  final CentroTrabalhoRepository _centroTrabalhoRepository;

  const GetTodosCentroTrabalhoUsecaseImpl(this._centroTrabalhoRepository);

  @override
  Future<List<CentroTrabalhoAggregate>> call(String search) {
    return _centroTrabalhoRepository.getTodosCentroTrabalho(search);
  }
}
