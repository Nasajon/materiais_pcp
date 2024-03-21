import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_finalizar_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_finalizar_usecase.dart';

class ChaoDeFabricaFinalizarStore extends NasajonStreamStore<bool> {
  final ChaoDeFabricaFinalizarUsecase _finalizarUsecase;

  ChaoDeFabricaFinalizarStore({required ChaoDeFabricaFinalizarUsecase finalizarUsecase})
      : _finalizarUsecase = finalizarUsecase,
        super(initialState: false);

  Future<void> apontar(ChaoDeFabricaFinalizarEntity finalizar) async {
    setLoading(true);

    try {
      await _finalizarUsecase(finalizar);
      update(true);
    } on ChaoDeFabricaFailure catch (e) {
      NhidsOverlay.error(message: e.errorMessage ?? '');

      setLoading(false);
      setError(e);
    }

    setLoading(false);
  }
}
