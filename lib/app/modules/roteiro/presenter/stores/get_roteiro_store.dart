import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_roteiro_por_id_usecase.dart';

class GetRoteiroStore extends NasajonStreamStore<RoteiroAggregate> {
  final GetRoteiroPorIdUsecase _getRoteiroPorIdUsecase;

  GetRoteiroStore(this._getRoteiroPorIdUsecase) : super(initialState: RoteiroAggregate.empty());

  Future<void> getRoteiroPorId(String roteiroId) async {
    setLoading(true);

    try {
      final response = await _getRoteiroPorIdUsecase(roteiroId);

      update(response, force: true);
    } on RoteiroFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }
}
