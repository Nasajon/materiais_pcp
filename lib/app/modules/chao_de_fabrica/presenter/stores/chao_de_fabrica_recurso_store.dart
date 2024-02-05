import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_recurso_usecase.dart';

class ChaoDeFabricaRecursoStore extends NasajonStreamStore<List<ChaoDeFabricaRecursoEntity>> {
  final GetChaoDeFabricaRecursoUsecase _getRecursoUsecase;

  ChaoDeFabricaRecursoStore({required GetChaoDeFabricaRecursoUsecase getRecursoUsecase})
      : _getRecursoUsecase = getRecursoUsecase,
        super(initialState: []);

  Future<void> getCentrosDeTrabalhos(
    String search, {
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    execute(
      () async {
        final response = await _getRecursoUsecase(search: search);
        return response;
      },
      delay: delay,
    );
  }
}
