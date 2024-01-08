import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/turno_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/errors/recurso_failures.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/usecases/get_turno_de_trabalho_usecase.dart';

class GetTurnoDeTrabalhoStore extends NasajonStreamStore<List<TurnoDeTrabalhoEntity>> {
  final GetTurnoDeTrabalhoUsecase _getTurnoDeTrabalhoUsecase;

  GetTurnoDeTrabalhoStore(this._getTurnoDeTrabalhoUsecase) : super(initialState: []);

  Future<void> getTurnos(String centroDeTrabalhoId, {required String search}) async {
    setLoading(true);

    try {
      final response = await _getTurnoDeTrabalhoUsecase(centroDeTrabalhoId, search: search);
      update(response);
    } on RecursoFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }

  Future<List<TurnoDeTrabalhoEntity>> getTurnoPorCentroDeTrabalho(String centroDeTrabalhoId,
      {required String search, String? ultimoTurnoDeTrabalho}) async {
    return await _getTurnoDeTrabalhoUsecase(centroDeTrabalhoId, search: search, ultimoTurnoTrabalhoId: ultimoTurnoDeTrabalho);
  }
}
