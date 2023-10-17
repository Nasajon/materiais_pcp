import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';

abstract class GetTurnoTrabalhoPorIdUsecase {
  Future<TurnoTrabalhoAggregate> call(String id);
}

class GetTurnoTrabalhoPorIdUsecaseImpl implements GetTurnoTrabalhoPorIdUsecase {
  final TurnoTrabalhoRepository _turnoTrabalhoRepository;

  const GetTurnoTrabalhoPorIdUsecaseImpl(this._turnoTrabalhoRepository);

  @override
  Future<TurnoTrabalhoAggregate> call(String id) {
    if (id.isEmpty) {
      throw IdNotFoundTurnoTrabalhoFailure(errorMessage: translation.messages.erroIdNaoInformado);
    }

    return _turnoTrabalhoRepository.getTurnoTrabalhoPorId(id);
  }
}
