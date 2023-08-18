import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_grupo_de_restricao_usecase.dart';

class GrupoDeRestricaoStore extends NasajonNotifierStore<List<GrupoDeRestricaoEntity>> {
  final GetGrupoDeRestricaoUsecase _getGrupoDeRestricaoUsecase;

  GrupoDeRestricaoStore(this._getGrupoDeRestricaoUsecase) : super(initialState: []);

  void getList({required search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() async {
      final response = await _getGrupoDeRestricaoUsecase(search);

      return response;
    }, delay: delay);
  }
}
