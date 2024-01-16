import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_by_id_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/usecases/save_grupo_de_restricao_usecase.dart';

class GrupoDeRestricaoFormStore extends NasajonStreamStore<GrupoDeRestricaoEntity?> {
  final GetGrupoDeRestricaoByIdUsecase _getGrupoDeRestricaoByIdUsecase;
  final SaveGrupoDeRestricaoUsecase _saveGrupoDeRestricaoUsecase;

  GrupoDeRestricaoFormStore(
    this._getGrupoDeRestricaoByIdUsecase,
    this._saveGrupoDeRestricaoUsecase,
  ) : super(initialState: null);

  Future<GrupoDeRestricaoEntity> pegarGrupoDeRestricao(String id) async {
    return await _getGrupoDeRestricaoByIdUsecase(id);
  }

  Future<void> salvar(GrupoDeRestricaoEntity grupoDeRestricao) async {
    try {
      setLoading(true);

      final response = await _saveGrupoDeRestricaoUsecase(grupoDeRestricao);

      update(response);
    } on Failure catch (error) {
      setError(error);
    }

    setLoading(false);
  }
}
