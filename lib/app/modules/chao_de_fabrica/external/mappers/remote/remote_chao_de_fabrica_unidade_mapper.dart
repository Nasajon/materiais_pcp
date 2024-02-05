import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_unidade_entity.dart';

class RemoteChaoDeFabricaUnidadeMapper {
  const RemoteChaoDeFabricaUnidadeMapper._();

  static ChaoDeFabricaUnidadeEntity fromMapToUnidadeEntity(Map<String, dynamic> map) {
    return ChaoDeFabricaUnidadeEntity(
      id: map['unidade'],
      codigo: map['codigo'],
      nome: map['nome'],
      decimal: map['decimais'],
    );
  }
}
