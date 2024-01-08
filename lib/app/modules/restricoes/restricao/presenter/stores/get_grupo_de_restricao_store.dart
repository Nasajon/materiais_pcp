import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_grupo_de_restricao_usecase.dart';

class GetGrupoDeRestricaoStore extends NasajonStreamStore<List<GrupoDeRestricaoEntity>> {
  final GetGrupoDeRestricaoUsecase _getGrupoDeRestricaoUsecase;

  GetGrupoDeRestricaoStore(this._getGrupoDeRestricaoUsecase) : super(initialState: []);

  Future<void> getList(String search, {String? ultimoGrupoDeRestricaoId}) async {
    setLoading(true);
    try {
      final response = await _getGrupoDeRestricaoUsecase(search, ultimoGrupoDeRestricaoId: ultimoGrupoDeRestricaoId);

      update(response);
    } on Failure catch (e) {
      setError(e);
    }
  }

  Future<List<GrupoDeRestricaoEntity>> getGruposDeRestricao(String search, {String? ultimoGrupoDeRestricaoId}) async {
    return await _getGrupoDeRestricaoUsecase(search, ultimoGrupoDeRestricaoId: ultimoGrupoDeRestricaoId);
  }
}
