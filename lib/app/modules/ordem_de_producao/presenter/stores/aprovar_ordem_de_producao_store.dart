import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/aprovar_ordem_de_producao_usecase.dart';

class AprovarOrdemDeProducaoStore extends NasajonStreamStore<bool> {
  final AprovarOrdemDeProducaoUsecase _aprovarOrdemDeProducaoUsecase;
  AprovarOrdemDeProducaoStore(this._aprovarOrdemDeProducaoUsecase) : super(initialState: false);

  Future<void> aprovar(String id) async {
    setLoading(true);
    try {
      await _aprovarOrdemDeProducaoUsecase(id);
      update(true, force: true);
    } on OrdemDeProducaoFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }
}
