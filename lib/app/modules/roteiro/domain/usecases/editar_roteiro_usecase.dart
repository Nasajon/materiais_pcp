import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/roteiro_repository.dart';

abstract class EditarRoteiroUsecase {
  Future<bool> call(RoteiroAggregate roteiro);
}

class EditarRoteiroUsecaseImpl implements EditarRoteiroUsecase {
  final RoteiroRepository _roteiroRepository;

  const EditarRoteiroUsecaseImpl(this._roteiroRepository);

  @override
  Future<bool> call(RoteiroAggregate roteiro) {
    if (!roteiro.isValid) {
      throw RoteiroIsNotValidFailure(
        errorMessage: translation.messages.erroDadosIncompletoOuAusenteDoEntidade(translation.fields.roteiro),
        stackTrace: StackTrace.current,
      );
    }

    return _roteiroRepository.editarRoteiro(roteiro);
  }
}
