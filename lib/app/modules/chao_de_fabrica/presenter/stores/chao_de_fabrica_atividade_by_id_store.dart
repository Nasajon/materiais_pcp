import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_atividade_by_id_usecase.dart';

class ChaoDeFabricaAtividadeByIdStore extends NasajonStreamStore<ChaoDeFabricaAtividadeAggregate> {
  final GetChaoDeFabricaAtividadeByIdUsecase _atividadeByIdUsecase;

  ChaoDeFabricaAtividadeByIdStore({required GetChaoDeFabricaAtividadeByIdUsecase atividadeByIdUsecase})
      : _atividadeByIdUsecase = atividadeByIdUsecase,
        super(initialState: ChaoDeFabricaAtividadeAggregate.empty());

  Future<void> getAtividade(String atividadeId) async {
    setLoading(true);

    try {
      final response = await _atividadeByIdUsecase(atividadeId);

      update(response, force: true);
    } on ChaoDeFabricaFailure catch (e) {
      NhidsOverlay.error(message: e.errorMessage ?? '');
      setError(e);
    }

    setLoading(false);
  }
}
