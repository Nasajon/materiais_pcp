import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_apontamento_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_apontamento_usecase.dart';

class ChaoDeFabricaApontamentoStore extends NasajonStreamStore<bool> {
  final ChaoDeFabricaApontamentoUsecase _apontamentoUsecase;

  ChaoDeFabricaApontamentoStore({required ChaoDeFabricaApontamentoUsecase apontamentoUsecase})
      : _apontamentoUsecase = apontamentoUsecase,
        super(initialState: false);

  Future<void> apontar(ChaoDeFabricaApontamentoEntity apontamento) async {
    setLoading(true);

    try {
      await _apontamentoUsecase(apontamento);
      update(true);
    } on ChaoDeFabricaFailure catch (e) {
      NhidsMessageDialog.error(message: e.errorMessage ?? '');

      setLoading(false);
      setError(e);
    }

    setLoading(false);
  }
}
