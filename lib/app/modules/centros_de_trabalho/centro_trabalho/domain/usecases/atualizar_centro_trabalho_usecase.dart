import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';

abstract class AtualizarCentroTrabalhoUsecase {
  Future<bool> call(CentroTrabalhoAggregate centroTrabalho);
}

class AtualizarCentroTrabalhoUsecaseImpl implements AtualizarCentroTrabalhoUsecase {
  final CentroTrabalhoRepository _centroTrabalhoRepository;

  const AtualizarCentroTrabalhoUsecaseImpl(this._centroTrabalhoRepository);

  @override
  Future<bool> call(CentroTrabalhoAggregate centroTrabalho) {
    if (centroTrabalho.id.isEmpty) {
      throw IdNotFoundCentroTrabalhoFailure(errorMessage: translation.messages.erroIdNaoInformado);
    }

    if (!centroTrabalho.isValid) {
      throw CentroTrabalhoIsNotValidFailure(
        errorMessage: translation.messages.erroDadosIncompletoOuAusenteDoEntidade(translation.fields.centroDeTrabalho),
        stackTrace: StackTrace.current,
      );
    }

    return _centroTrabalhoRepository.atualizarCentroTrabalho(centroTrabalho);
  }
}
