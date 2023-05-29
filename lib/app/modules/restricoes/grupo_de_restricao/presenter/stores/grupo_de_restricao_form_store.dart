import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_by_id_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/save_grupo_de_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/states/grupo_de_restricao_form_state.dart';

class GrupoDeRestricaoFormStore extends NasajonNotifierStore<GrupoDeRestricaoFormState> {
  final GetGrupoDeRestricaoByIdUsecase _getGrupoDeRestricaoByIdUsecase;
  final SaveGrupoDeRestricaoUsecase _saveGrupoDeRestricaoUsecase;

  GrupoDeRestricaoFormStore(
    this._getGrupoDeRestricaoByIdUsecase,
    this._saveGrupoDeRestricaoUsecase,
  ) : super(initialState: GrupoDeRestricaoFormState.empty());

  Future<GrupoDeRestricaoEntity> pegarGrupoDeRestricao(String id) async {
    return await _getGrupoDeRestricaoByIdUsecase(id);
  }

  Future<void> salvar(GrupoDeRestricaoEntity grupoDeRestricao) async {
    try {
      setLoading(true);

      await _saveGrupoDeRestricaoUsecase(grupoDeRestricao);

      clear();
    } on Failure {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void clear() {
    update(state.copyWith(grupoDeRestricao: () => null));
  }
}
