import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';

abstract class GetTodosFichaTecnicaUsecase {
  Future<List<FichaTecnicaAggregate>> call(String search);
}

class GetTodosFichaTecnicaUsecaseImpl implements GetTodosFichaTecnicaUsecase {
  final FichaTecnicaRepository _fichaTecnicaRepository;

  const GetTodosFichaTecnicaUsecaseImpl(this._fichaTecnicaRepository);

  @override
  Future<List<FichaTecnicaAggregate>> call(String search) {
    return _fichaTecnicaRepository.getTodosFichaTecnica(search);
  }
}
