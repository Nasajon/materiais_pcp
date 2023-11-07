import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_ordem_de_producao_por_id_usecase.dart';

class GetOrdemDeProducaoPorIdStore extends NasajonStreamStore<OrdemDeProducaoAggregate?> {
  final GetOrdemDeProducaoPorIdUsecase _getOrdemDeProducaoPorIdUsecase;

  GetOrdemDeProducaoPorIdStore(this._getOrdemDeProducaoPorIdUsecase) : super(initialState: null);

  Future<void> getOrdem(String ordemDeProducaoId) async {
    setLoading(true);

    try {
      final response = await _getOrdemDeProducaoPorIdUsecase(ordemDeProducaoId);

      update(response);
    } on OrdemDeProducaoAggregate catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }
}
