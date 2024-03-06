import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_apontamento_entity.dart';

abstract interface class RemoteChaoDeFabricaApontamentoDatasource {
  Future<void> call(ChaoDeFabricaApontamentoEntity apontamento);
}
