import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';

class RemoteProdutoMapper {
  const RemoteProdutoMapper._();

  static ProdutoEntity fromMapToProdutoEntity(Map<String, dynamic> map) {
    return ProdutoEntity(
      id: map['produto'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }
}
