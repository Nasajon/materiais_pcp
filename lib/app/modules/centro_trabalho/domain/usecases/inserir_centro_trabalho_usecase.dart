import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';

abstract class InserirCentroTrabalhoUsecase {
  Future<CentroTrabalhoAggregate> call(CentroTrabalhoAggregate centroTrabalho);
}

class InserirCentroTrabalhoUsecaseImpl implements InserirCentroTrabalhoUsecase {
  final CentroTrabalhoRepository _centroTrabalhoRepository;

  const InserirCentroTrabalhoUsecaseImpl(this._centroTrabalhoRepository);

  @override
  Future<CentroTrabalhoAggregate> call(CentroTrabalhoAggregate centroTrabalho) {
    if (!centroTrabalho.isValid) {
      throw IncompleteOrMissingDataCentroTrabalhoFailure(
        errorMessage: translation.messages.erroDadosIncompletoOuAusenteDoEntidade(translation.titles.centroDeTrabalho),
      );
    }

    return _centroTrabalhoRepository.inserirCentroTrabalho(centroTrabalho);
  }
}
