import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/confirmar_sequenciamento_ordem_de_producao_usecase.dart';

class ConfirmarSequenciamentoStore extends NasajonStreamStore<bool> {
  final ConfirmarSequenciamentoOrdemDeProducaoUsecase _sequenciarOrdemDeProducaoUsecase;

  ConfirmarSequenciamentoStore({required ConfirmarSequenciamentoOrdemDeProducaoUsecase sequenciarOrdemDeProducaoUsecase})
      : _sequenciarOrdemDeProducaoUsecase = sequenciarOrdemDeProducaoUsecase,
        super(initialState: false);

  Future<void> confirmarSequenciamentoOrdemDeProducao(SequenciamentoAggregate sequenciamento) async {
    setLoading(true);

    try {
      await _sequenciarOrdemDeProducaoUsecase(sequenciamento);
      update(true);
    } on OrdemDeProducaoFailure catch (e) {
      setError(e);
    } finally {
      setLoading(false, force: true);
    }
  }
}
