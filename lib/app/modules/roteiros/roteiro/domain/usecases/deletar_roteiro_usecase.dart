import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/roteiro_repository.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';

abstract class DeletarRoteiroUsecase {
  Future<bool> call(String roteiroId);
}

class DeletarRoteiroUsecaseImpl implements DeletarRoteiroUsecase {
  final RoteiroRepository _roteiroRepository;

  const DeletarRoteiroUsecaseImpl(this._roteiroRepository);

  @override
  Future<bool> call(String roteiroId) {
    if (roteiroId.isEmpty) {
      throw IdNotFoundRoteiroFailure(errorMessage: translation.messages.erroIdNaoInformado, stackTrace: StackTrace.current);
    }

    return _roteiroRepository.deletarRoteiro(roteiroId);
  }
}
