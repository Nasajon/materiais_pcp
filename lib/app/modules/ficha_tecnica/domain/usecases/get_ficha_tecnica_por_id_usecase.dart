import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';

abstract class GetFichaTecnicaPorIdUsecase {
  Future<FichaTecnicaAggregate> call(String id);
}

class GetFichaTecnicaPorIdUsecaseImpl implements GetFichaTecnicaPorIdUsecase {
  final FichaTecnicaRepository _fichaTecnicaRepository;

  const GetFichaTecnicaPorIdUsecaseImpl(this._fichaTecnicaRepository);

  @override
  Future<FichaTecnicaAggregate> call(String id) {
    if (id.isEmpty) {
      throw IdNotFoundFichaTecnicaFailure(errorMessage: translation.messages.erroIdNaoInformado);
    }

    return _fichaTecnicaRepository.getFichaTecnicaPorId(id);
  }
}
