import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';

abstract class GetTurnosTrabalhosUsecase {
  Future<List<TurnoTrabalhoAggregate>> call({required String search});
}

class GetTurnosTrabalhosUsecaseImpl implements GetTurnosTrabalhosUsecase {
  final TurnoTrabalhoRepository _turnoTrabalhoRepository;

  const GetTurnosTrabalhosUsecaseImpl(this._turnoTrabalhoRepository);

  @override
  Future<List<TurnoTrabalhoAggregate>> call({required String search}) {
    return _turnoTrabalhoRepository.getTurnosTrabalhos(search: search);
  }
}
