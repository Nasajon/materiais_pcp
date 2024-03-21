import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_finalizar_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_finalizar_repository.dart';

abstract interface class ChaoDeFabricaFinalizarUsecase {
  Future<void> call(ChaoDeFabricaFinalizarEntity finalizar);
}

class ChaoDeFabricaFinalizarUsecaseImpl implements ChaoDeFabricaFinalizarUsecase {
  final ChaoDeFabricaFinalizarRepository _finalizarRepository;

  const ChaoDeFabricaFinalizarUsecaseImpl({required ChaoDeFabricaFinalizarRepository finalizarRepository})
      : _finalizarRepository = finalizarRepository;

  @override
  Future<void> call(ChaoDeFabricaFinalizarEntity finalizar) {
    return _finalizarRepository(finalizar);
  }
}
