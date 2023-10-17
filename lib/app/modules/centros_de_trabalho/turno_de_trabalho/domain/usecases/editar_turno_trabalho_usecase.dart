import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
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
      throw TurnoTrabalhoIsNotValidFailure(
        errorMessage: translation.messages.erroDadosIncompletoOuAusenteDoEntidade(translation.fields.turnosDeTrabalho),
        stackTrace: StackTrace.current,
      );
    }

    return _turnoTrabalhoRepository.editar(turno);
  }
}
