import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_operacao_repository.dart';

abstract interface class GetOperacaoUsecase {
  Future<List<OperacaoAggregate>> call(List<String> roteirosId);
}

class GetOperacaoUsecaseImpl implements GetOperacaoUsecase {
  final GetOperacaoRepository _getOperacaoRepository;

  const GetOperacaoUsecaseImpl({required GetOperacaoRepository getOperacaoRepository}) : _getOperacaoRepository = getOperacaoRepository;

  @override
  Future<List<OperacaoAggregate>> call(List<String> roteirosId) {
    if (roteirosId.isEmpty) {
      throw IdNotFoundOrdemDeProducaoFailure(
        errorMessage: translation.messages.erroIdNaoInformado,
        stackTrace: StackTrace.current,
      );
    }

    return _getOperacaoRepository(roteirosId);
  }
}
