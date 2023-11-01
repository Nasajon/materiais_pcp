import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';

abstract interface class InserirOrdemDeProducaoUsecase {
  Future<OrdemDeProducaoAggregate> call(OrdemDeProducaoAggregate ordemDeProducao);
}

class InserirOrdemDeProducaoUsecaseImpl implements InserirOrdemDeProducaoUsecase {
  final OrdemDeProducaoRepository _ordemDeProducaoRepository;

  const InserirOrdemDeProducaoUsecaseImpl(this._ordemDeProducaoRepository);

  @override
  Future<OrdemDeProducaoAggregate> call(OrdemDeProducaoAggregate ordemDeProducao) {
    if (!ordemDeProducao.isValid) {
      throw InvalidOrdemDeProducaoFailure(
        errorMessage: translation.messages.erroDadosIncompletoOuAusenteDaEntidade(translation.titles.ordemDeProducao),
      );
    }

    return _ordemDeProducaoRepository.inserir(ordemDeProducao);
  }
}
