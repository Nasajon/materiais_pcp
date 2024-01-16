import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/turno_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/error/restricao_failure.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/get_turno_de_trabalho_usecase.dart';

class GetTurnoDeTrabalhoStore extends NasajonStreamStore<List<TurnoDeTrabalhoEntity>> {
  final GetTurnoDeTrabalhoUsecase _getTurnoDeTrabalhoUsecase;

  GetTurnoDeTrabalhoStore(this._getTurnoDeTrabalhoUsecase) : super(initialState: []);

  Future<void> getTurnos(String centroDeTrabalhoId, {required String search}) async {
    setLoading(true);

    try {
      final response = await _getTurnoDeTrabalhoUsecase(centroDeTrabalhoId, search: search);
      update(response);
    } on RestricaoFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }

  Future<List<TurnoDeTrabalhoEntity>> getTurnoPorCentroDeTrabalho(String centroDeTrabalhoId,
      {required String search, String? ultimoTurnoDeTrabalho, required List<TurnoDeTrabalhoEntity> turnos}) async {
    final listTurnos = await _getTurnoDeTrabalhoUsecase(centroDeTrabalhoId, search: search, ultimoTurnoTrabalhoId: ultimoTurnoDeTrabalho);

    turnos.forEach((turno) {
      listTurnos.removeWhere((element) => element.id == turno.id);
    });

    return listTurnos;
  }
}
