import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

import '../../domain/usecases/get_grupo_de_recurso_by_id_usecase.dart';
import '../../domain/usecases/save_grupo_de_recurso_usecase.dart';
import 'states/grupo_de_recurso_form_state.dart';

class GrupoDeRecursoFormStore extends NasajonNotifierStore<GrupoDeRecursoFormState> {
  final GetGrupoDeRecursoByIdUsecase _getGrupoDeRecursoByIdUsecase;
  final SaveGrupoDeRecursoUsecase _saveGrupoDeRecursoUsecase;

  GrupoDeRecursoFormStore(
    this._getGrupoDeRecursoByIdUsecase,
    this._saveGrupoDeRecursoUsecase,
  ) : super(initialState: GrupoDeRecursoFormState.empty());

  Future<GrupoDeRecurso> pegarGrupoDeRecurso(String id) async {
    return await _getGrupoDeRecursoByIdUsecase(id);
  }

  Future<void> salvar(GrupoDeRecurso grupoDeRecurso) async {
    try {
      setLoading(true);

      await _saveGrupoDeRecursoUsecase(grupoDeRecurso);

      clear();
    } on Failure {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void clear() {
    update(state.copyWith(grupoDeRecurso: () => null));
  }
}
