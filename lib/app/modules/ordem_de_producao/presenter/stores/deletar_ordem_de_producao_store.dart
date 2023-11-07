import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/deletar_ordem_de_producao_usecase.dart';

class DeletarOrdemDeProducaoStore extends NasajonStreamStore<bool> {
  final DeletarOrdemDeProducaoUsecase _deletarOrdemDeProducaoUsecase;
  DeletarOrdemDeProducaoStore(this._deletarOrdemDeProducaoUsecase) : super(initialState: false);

  Future<void> deletarOrdemDeProducaoPorId(String id) async {
    setLoading(true);
    try {
      await _deletarOrdemDeProducaoUsecase(id);
      update(true, force: true);
    } on OrdemDeProducaoFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }
}
