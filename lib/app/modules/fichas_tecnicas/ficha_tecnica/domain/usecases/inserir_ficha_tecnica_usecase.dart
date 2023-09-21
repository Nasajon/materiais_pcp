import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';

abstract class InserirFichaTecnicaUsecase {
  Future<FichaTecnicaAggregate> call(FichaTecnicaAggregate centroTrabalho);
}

class InserirFichaTecnicaUsecaseImpl implements InserirFichaTecnicaUsecase {
  final FichaTecnicaRepository _fichaTecnicaRepository;

  const InserirFichaTecnicaUsecaseImpl(this._fichaTecnicaRepository);

  @override
  Future<FichaTecnicaAggregate> call(FichaTecnicaAggregate centroTrabalho) {
    if (!centroTrabalho.isValid) {
      throw IncompleteOrMissingDataFichaTecnicaFailure(
        errorMessage: translation.messages.erroDadosIncompletoOuAusenteDoEntidade(translation.titles.centroDeTrabalho),
      );
    }

    return _fichaTecnicaRepository.inserirFichaTecnica(centroTrabalho);
  }
}
