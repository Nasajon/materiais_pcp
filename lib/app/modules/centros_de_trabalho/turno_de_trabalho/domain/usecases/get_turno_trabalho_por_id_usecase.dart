import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';

abstract class GetTurnoTrabalhoPorIdUsecase {
  Future<TurnoTrabalhoAggregate> call(String id);
}

class GetTurnoTrabalhoUsecasePorIdImpl implements GetTurnoTrabalhoPorIdUsecase {
  final TurnoTrabalhoRepository _turnoTrabalhoRepository;

  const GetTurnoTrabalhoUsecasePorIdImpl(this._turnoTrabalhoRepository);

  @override
  Future<TurnoTrabalhoAggregate> call(String id) {
    if (id.isEmpty) {
      // TODO: Criar validação
    }

    return _turnoTrabalhoRepository.getTurnoTrabalhoPorId(id);
  }
}
