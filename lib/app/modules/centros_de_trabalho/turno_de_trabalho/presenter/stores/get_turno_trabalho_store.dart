import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/get_turno_trabalho_por_id_usecase.dart';

class GetTurnoTrabalhoPorIdStore extends NasajonStreamStore<TurnoTrabalhoAggregate?> {
  final GetTurnoTrabalhoPorIdUsecase _getTurnoTrabalhoPorIdUsecase;

  GetTurnoTrabalhoPorIdStore(this._getTurnoTrabalhoPorIdUsecase) : super(initialState: null);

  Future<void> getTurnoTrabalhoPorId(String id) async {
    setLoading(true, force: true);

    try {
      final response = await _getTurnoTrabalhoPorIdUsecase(id);

      update(response, force: true);
    } on Failure catch (e) {
      setError(e);
    }
  }
}
