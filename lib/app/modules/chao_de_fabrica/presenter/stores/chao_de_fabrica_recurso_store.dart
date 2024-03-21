import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_recurso_usecase.dart';

class ChaoDeFabricaRecursoStore extends NasajonStreamStore<List<ChaoDeFabricaRecursoEntity>> {
  final GetChaoDeFabricaRecursoUsecase _getRecursoUsecase;

  ChaoDeFabricaRecursoStore({required GetChaoDeFabricaRecursoUsecase getRecursoUsecase})
      : _getRecursoUsecase = getRecursoUsecase,
        super(initialState: []);

  Future<void> getRecursos(
    String search, {
    required String grupoDeRecursoId,
  }) async {
    setLoading(true);

    try {
      final response = await _getRecursoUsecase(search: search, grupoDeRecursoId: grupoDeRecursoId);

      update(response);
    } on ChaoDeFabricaFailure catch (e) {
      NhidsOverlay.error(message: e.errorMessage ?? '');
    }

    setLoading(false);
  }
}
