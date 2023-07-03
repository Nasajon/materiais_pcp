import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';

abstract class InserirTurnoTrabalhoUsecase {
  Future<TurnoTrabalhoAggregate> call(TurnoTrabalhoAggregate turno);
}

class InserirTurnoTrabalhoUsecaseImpl implements InserirTurnoTrabalhoUsecase {
  final TurnoTrabalhoRepository _turnoTrabalhoRepository;

  const InserirTurnoTrabalhoUsecaseImpl(this._turnoTrabalhoRepository);

  @override
  Future<TurnoTrabalhoAggregate> call(TurnoTrabalhoAggregate turno) {
    if (!turno.isValid) {
      // TODO: Criar mensagem de erro
    }

    return _turnoTrabalhoRepository.inserir(turno);
  }
}
