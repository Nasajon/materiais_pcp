import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';

abstract class InserirTurnoTrabalhoUsecase {
  Future<TurnoTrabalhoAggregate> call(TurnoTrabalhoAggregate turno);
}

class InserirTurnoTrabalhoUsecaseImpl implements InserirTurnoTrabalhoUsecase {
  final TurnoTrabalhoRepository _turnoTrabalhoRepository;

  const InserirTurnoTrabalhoUsecaseImpl(this._turnoTrabalhoRepository);

  @override
  Future<TurnoTrabalhoAggregate> call(TurnoTrabalhoAggregate turno) {
    if (!turno.isValid) {
      throw TurnoTrabalhoIsNotValidFailure(
        errorMessage: translation.messages.erroDadosIncompletoOuAusenteDoEntidade(translation.fields.turnosDeTrabalho),
        stackTrace: StackTrace.current,
      );
    }

    return _turnoTrabalhoRepository.inserir(turno);
  }
}
