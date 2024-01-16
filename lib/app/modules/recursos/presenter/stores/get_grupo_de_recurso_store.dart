import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/get_grupo_de_recurso_usecase.dart';

class GetGrupoDeRecursoStore extends NasajonStreamStore<List<RecursoGrupoDeRecurso>> {
  final GetGrupoDeRecursoUsecase _getGrupoDeRecursoUsecase;

  GetGrupoDeRecursoStore(this._getGrupoDeRecursoUsecase) : super(initialState: []);

  Future<void> getGrupos(String search) async {
    setLoading(true);

    try {
      final response = await _getGrupoDeRecursoUsecase(search: search);

      update(response);
    } on Failure catch (e) {
      setError(e);
    }
  }

  Future<List<RecursoGrupoDeRecurso>> getGrupoDeRecurso(String search, {String? ultimoGrupoDeRecursoId}) async {
    final response = await _getGrupoDeRecursoUsecase(search: search);

    return response;
  }
}
