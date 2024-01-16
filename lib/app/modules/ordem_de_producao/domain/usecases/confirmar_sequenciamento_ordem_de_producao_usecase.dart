import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/sequenciamento_repository.dart';

abstract interface class ConfirmarSequenciamentoOrdemDeProducaoUsecase {
  Future<bool> call(SequenciamentoAggregate sequenciamento);
}

class ConfirmarSequenciamentoOrdemDeProducaoUsecaseImpl implements ConfirmarSequenciamentoOrdemDeProducaoUsecase {
  final SequenciamentoRepository _sequenciamentoRepository;

  const ConfirmarSequenciamentoOrdemDeProducaoUsecaseImpl({required SequenciamentoRepository sequenciamentoRepository})
      : _sequenciamentoRepository = sequenciamentoRepository;

  @override
  Future<bool> call(SequenciamentoAggregate sequenciamento) {
    return _sequenciamentoRepository.sequenciarOrdemDeProducao(sequenciamento);
  }
}
