import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_ordem_de_producao_entity.dart';

class RemoteChaoDeFabricaOrdemDeProducaoMapper {
  const RemoteChaoDeFabricaOrdemDeProducaoMapper._();

  static ChaoDeFabricaOrdemDeProducaoEntity fromMapToOrdemDeProducaoEntity(Map<String, dynamic> map) {
    return ChaoDeFabricaOrdemDeProducaoEntity(
      id: map['ordem_de_producao'],
      codigo: map['codigo'],
      quantidade: DoubleVO(map['quantidade']),
    );
  }
}
