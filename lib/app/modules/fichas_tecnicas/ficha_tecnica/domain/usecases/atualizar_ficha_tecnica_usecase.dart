import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';

abstract class AtualizarFichaTecnicaUsecase {
  Future<bool> call(FichaTecnicaAggregate fichaTecnica);
}

class AtualizarFichaTecnicaUsecaseImpl implements AtualizarFichaTecnicaUsecase {
  final FichaTecnicaRepository _fichaTecnicaRepository;

  const AtualizarFichaTecnicaUsecaseImpl(this._fichaTecnicaRepository);

  @override
  Future<bool> call(FichaTecnicaAggregate fichaTecnica) {
    if (fichaTecnica.id.isEmpty) {
      throw IdNotFoundFichaTecnicaFailure(errorMessage: translation.messages.erroIdNaoInformado);
    }

    return _fichaTecnicaRepository.atualizarFichaTecnica(fichaTecnica);
  }
}
