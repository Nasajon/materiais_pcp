import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_restricao_por_id_usecase.dart';

class GetRestricaoStore extends NasajonStreamStore<RestricaoAggregate?> {
  final GetRestricaoPorIdUsecase _getRestricaoPorIdUsecase;

  GetRestricaoStore(this._getRestricaoPorIdUsecase) : super(initialState: null);

  Future<void> getRestricaoPorId(String id) async {
    setLoading(true, force: true);

    try {
      final response = await _getRestricaoPorIdUsecase(id);

      update(response, force: true);
    } on Failure catch (e) {
      setError(e);
    }
  }
}
