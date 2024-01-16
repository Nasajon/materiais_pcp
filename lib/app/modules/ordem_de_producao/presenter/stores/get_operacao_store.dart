// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_operacao_usecase.dart';

class GetOperacaoStore extends NasajonNotifierStore<List<OperacaoAggregate>> {
  final GetOperacaoUsecase _getOperacaoUsecase;

  GetOperacaoStore(this._getOperacaoUsecase) : super(initialState: []);

  void getList(List<String> roteirosId) async {
    setLoading(true);

    try {
      final response = await _getOperacaoUsecase(roteirosId);

      update(response);
    } on OrdemDeProducaoFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }

  void cleanList() async {
    update([]);
  }
}
