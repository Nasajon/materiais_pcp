import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/dto/sequenciamento_dto.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/gerar_sequenciamento_usecase.dart';

class GerarSequenciamentoStore extends NasajonNotifierStore<SequenciamentoAggregate> {
  final GerarSequenciamentoUsecase _gerarSequenciamentoUsecase;
  GerarSequenciamentoStore(this._gerarSequenciamentoUsecase) : super(initialState: SequenciamentoAggregate.empty());

  Future<void> gerarSequenciamento(SequenciamentoDTO sequenciamentoDTO) async {
    setLoading(true);

    try {
      final response = await _gerarSequenciamentoUsecase(sequenciamentoDTO);
      update(response);
    } on OrdemDeProducaoFailure catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
