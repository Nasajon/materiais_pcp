import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';

abstract interface class AtualizarOrdemDeProducaoUsecase {
  Future<bool> call(OrdemDeProducaoAggregate ordemDeProducao);
}

class AtualizarOrdemDeProducaoUsecaseImpl implements AtualizarOrdemDeProducaoUsecase {
  final OrdemDeProducaoRepository _ordemDeProducaoRepository;

  const AtualizarOrdemDeProducaoUsecaseImpl({required OrdemDeProducaoRepository ordemDeProducaoRepository})
      : _ordemDeProducaoRepository = ordemDeProducaoRepository;

  @override
  Future<bool> call(OrdemDeProducaoAggregate ordemDeProducao) {
    if (!ordemDeProducao.isValid) {
      throw InvalidOrdemDeProducaoFailure(
        errorMessage: translation.messages.erroDadosIncompletoOuAusenteDaEntidade(translation.titles.ordemDeProducao),
      );
    }

    return _ordemDeProducaoRepository.atualizar(ordemDeProducao);
  }
}
