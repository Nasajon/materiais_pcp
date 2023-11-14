import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

import '../../domain/usecases/get_grupo_de_recurso_by_id_usecase.dart';
import '../../domain/usecases/save_grupo_de_recurso_usecase.dart';

class GrupoDeRecursoFormStore extends NasajonStreamStore<GrupoDeRecurso?> {
  final GetGrupoDeRecursoByIdUsecase _getGrupoDeRecursoByIdUsecase;
  final SaveGrupoDeRecursoUsecase _saveGrupoDeRecursoUsecase;

  GrupoDeRecursoFormStore(
    this._getGrupoDeRecursoByIdUsecase,
    this._saveGrupoDeRecursoUsecase,
  ) : super(initialState: null);

  Future<GrupoDeRecurso> pegarGrupoDeRecurso(String id) async {
    return await _getGrupoDeRecursoByIdUsecase(id);
  }

  Future<void> salvar(GrupoDeRecurso grupoDeRecurso) async {
    try {
      setLoading(true);

      final response = await _saveGrupoDeRecursoUsecase(grupoDeRecurso);

      update(response);
    } on Failure {
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
