import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/roteiro_repository.dart';

abstract class GetRoteiroPorIdUsecase {
  Future<RoteiroAggregate> call(String roteiroId);
}

class GetRoteiroPorIdUsecaseImpl implements GetRoteiroPorIdUsecase {
  final RoteiroRepository _roteiroRepository;

  const GetRoteiroPorIdUsecaseImpl(this._roteiroRepository);

  @override
  Future<RoteiroAggregate> call(String roteiroId) {
    if (roteiroId.isEmpty) {
      throw IdNotFoundRoteiroFailure(errorMessage: translation.messages.erroIdNaoInformado, stackTrace: StackTrace.current);
    }

    return _roteiroRepository.getRoteiroPorId(roteiroId);
  }
}
