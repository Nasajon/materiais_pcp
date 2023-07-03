import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';

abstract class EditarTurnoTrabalhoUsecase {
  Future<bool> call(TurnoTrabalhoAggregate turno);
}

class EditarTurnoTrabalhoUsecaseImpl implements EditarTurnoTrabalhoUsecase {
  final TurnoTrabalhoRepository _turnoTrabalhoRepository;

  const EditarTurnoTrabalhoUsecaseImpl(this._turnoTrabalhoRepository);

  @override
  Future<bool> call(TurnoTrabalhoAggregate turno) {
    if (!turno.isValid) {
      // TODO: Criar mensagem de erro
    }

    return _turnoTrabalhoRepository.editar(turno);
  }
}
