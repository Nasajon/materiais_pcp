import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';

abstract class DeletarFichaTecnicaUsecase {
  Future<bool> call(String id);
}

class DeletarFichaTecnicaUsecaseImpl implements DeletarFichaTecnicaUsecase {
  final FichaTecnicaRepository _fichaTecnicaRepository;

  const DeletarFichaTecnicaUsecaseImpl(this._fichaTecnicaRepository);

  @override
  Future<bool> call(String id) {
    if (id.isEmpty) {
      throw IdNotFoundFichaTecnicaFailure(errorMessage: translation.messages.erroIdNaoInformado);
    }

    return _fichaTecnicaRepository.deletarFichaTecnica(id);
  }
}
