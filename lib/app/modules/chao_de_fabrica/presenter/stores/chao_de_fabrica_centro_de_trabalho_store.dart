import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_centro_de_trabalho_usecase.dart';

class ChaoDeFabricaCentroDeTrabalhoStore extends NasajonStreamStore<List<ChaoDeFabricaCentroDeTrabalhoEntity>> {
  final GetChaoDeFabricaCentroDeTrabalhoUsecase _getCentroDeTrabalhoUsecase;

  ChaoDeFabricaCentroDeTrabalhoStore({required GetChaoDeFabricaCentroDeTrabalhoUsecase getCentroDeTrabalhoUsecase})
      : _getCentroDeTrabalhoUsecase = getCentroDeTrabalhoUsecase,
        super(initialState: []);

  Future<void> getCentrosDeTrabalhos(
    String search, {
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    execute(
      () async {
        final response = await _getCentroDeTrabalhoUsecase(search: search);
        return response;
      },
      delay: delay,
    );
  }
}
