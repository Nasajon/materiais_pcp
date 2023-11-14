import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/roteiro_repository.dart';

abstract class InserirRoteiroUsecase {
  Future<String> call(RoteiroAggregate roteiro);
}

class InserirRoteiroUsecaseImpl implements InserirRoteiroUsecase {
  final RoteiroRepository _roteiroRepository;

  const InserirRoteiroUsecaseImpl(this._roteiroRepository);

  @override
  Future<String> call(RoteiroAggregate roteiro) {
    if (!roteiro.isValid) {
      throw RoteiroIsNotValidFailure(
        errorMessage: translation.messages.erroDadosIncompletoOuAusenteDoEntidade(translation.fields.roteiro),
        stackTrace: StackTrace.current,
      );
    }

    return _roteiroRepository.inserirRoteiro(roteiro);
  }
}
