// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_grupo_de_recurso_usecase.dart';

class GetGrupoDeRecursoStore extends NasajonNotifierStore<List<GrupoDeRecursoEntity>> {
  final GetGrupoDeRecursoUsecase _getGrupoDeRecursoUsecase;

  GetGrupoDeRecursoStore(this._getGrupoDeRecursoUsecase) : super(initialState: []);

  void getList({required search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() async {
      final response = await _getGrupoDeRecursoUsecase(search);

      return response;
    }, delay: delay);
  }

  Future<List<GrupoDeRecursoEntity>> getListGrupoDeRecurso({required search}) async {
    return _getGrupoDeRecursoUsecase(search);
  }
}
