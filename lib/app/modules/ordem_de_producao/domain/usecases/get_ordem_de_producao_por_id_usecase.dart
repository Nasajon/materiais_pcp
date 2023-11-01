import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';

abstract interface class GetOrdemDeProducaoPorIdUsecase {
  Future<OrdemDeProducaoAggregate> call(String ordemDeProducaoId);
}

class GetOrdemDeProducaoPorIdUsecaseImpl implements GetOrdemDeProducaoPorIdUsecase {
  final OrdemDeProducaoRepository _ordemDeProducaoRepository;

  const GetOrdemDeProducaoPorIdUsecaseImpl(this._ordemDeProducaoRepository);

  @override
  Future<OrdemDeProducaoAggregate> call(String ordemDeProducaoId) {
    if (ordemDeProducaoId.isEmpty) {
      throw IdNotFoundOrdemDeProducaoFailure(
        errorMessage: translation.messages.erroIdNaoInformado,
        stackTrace: StackTrace.current,
      );
    }

    return _ordemDeProducaoRepository.getOrdemDeProducaoPorId(ordemDeProducaoId);
  }
}
