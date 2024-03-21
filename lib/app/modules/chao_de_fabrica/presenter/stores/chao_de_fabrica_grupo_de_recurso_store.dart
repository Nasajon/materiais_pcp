import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_grupo_de_recurso_usecase.dart';

class ChaoDeFabricaGrupoDeRecursoStore extends NasajonStreamStore<List<ChaoDeFabricaGrupoDeRecursoEntity>> {
  final GetChaoDeFabricaGrupoDeRecursoUsecase _getGrupoDeRecursoUsecase;

  ChaoDeFabricaGrupoDeRecursoStore({required GetChaoDeFabricaGrupoDeRecursoUsecase getGrupoDeRecursoUsecase})
      : _getGrupoDeRecursoUsecase = getGrupoDeRecursoUsecase,
        super(initialState: []);

  Future<void> getGrupoDeRecurso({
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    execute(
      () async {
        final response = await _getGrupoDeRecursoUsecase();
        return response;
      },
      delay: delay,
    );
  }
}
