import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_finalizar_entity.dart';

abstract interface class ChaoDeFabricaFinalizarRepository {
  Future<void> call(ChaoDeFabricaFinalizarEntity finalizar);
}