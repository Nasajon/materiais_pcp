import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/atualizar_ordem_de_producao_usecase.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/inserir_ordem_de_producao_usecase.dart';

class InserirEditarOrdemDeProducaoStore extends NasajonStreamStore<OrdemDeProducaoAggregate> {
  final InserirOrdemDeProducaoUsecase _inserirOrdemDeProducaoUsecase;
  final AtualizarOrdemDeProducaoUsecase _atualizarOrdemDeProducaoUsecase;

  InserirEditarOrdemDeProducaoStore(this._inserirOrdemDeProducaoUsecase, this._atualizarOrdemDeProducaoUsecase)
      : super(initialState: OrdemDeProducaoAggregate.empty());

  Future<void> inserir(OrdemDeProducaoAggregate ordem) async {
    setLoading(true);

    try {
      final response = await _inserirOrdemDeProducaoUsecase(ordem);

      update(response);
    } on OrdemDeProducaoFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }

  Future<void> atualizar(OrdemDeProducaoAggregate ordem) async {
    setLoading(true);

    try {
      await _atualizarOrdemDeProducaoUsecase(ordem);

      update(ordem);
    } on OrdemDeProducaoFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }
}
