import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_produto_entity.dart';

class RemoteChaoDeFabricaProdutoMapper {
  const RemoteChaoDeFabricaProdutoMapper._();

  static ChaoDeFabricaProdutoEntity fromMapToProdutoEntity(Map<String, dynamic> map) {
    return ChaoDeFabricaProdutoEntity(
      id: map['produto'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }
}
