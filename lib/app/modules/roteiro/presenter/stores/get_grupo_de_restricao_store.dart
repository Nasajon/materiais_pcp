import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_grupo_de_restricao_usecase.dart';

class GetGrupoDeRestricaoStore extends NasajonNotifierStore<List<GrupoDeRestricaoEntity>> {
  final GetGrupoDeRestricaoUsecase _getGrupoDeRestricaoUsecase;

  GetGrupoDeRestricaoStore(this._getGrupoDeRestricaoUsecase) : super(initialState: []);

  void getList({required search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() async {
      final response = await _getGrupoDeRestricaoUsecase(search);

      return response;
    }, delay: delay);
  }

  Future<List<GrupoDeRestricaoEntity>> getListGrupoDeRestricao({required search}) {
    return _getGrupoDeRestricaoUsecase(search);
  }
}
