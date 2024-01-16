import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';

abstract class GetTurnoTrabalhoRecenteUsecase {
  Future<List<TurnoTrabalhoAggregate>> call();
}

class GetTurnoTrabalhoRecenteUsecaseImpl implements GetTurnoTrabalhoRecenteUsecase {
  final TurnoTrabalhoRepository _turnoTrabalhoRepository;

  const GetTurnoTrabalhoRecenteUsecaseImpl(this._turnoTrabalhoRepository);

  @override
  Future<List<TurnoTrabalhoAggregate>> call() {
    return _turnoTrabalhoRepository.getTurnoTrabalhoRecentes();
  }
}
