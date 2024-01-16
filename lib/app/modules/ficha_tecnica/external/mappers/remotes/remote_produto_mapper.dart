import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';

class RemoteProdutoMapper {
  const RemoteProdutoMapper._();

  static ProdutoEntity fromMapToProduto(Map<String, dynamic> map) {
    return ProdutoEntity(
      id: map['produto'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }

  static Map<String, dynamic> fromProdutoToMap(ProdutoEntity produto) {
    return {
      'produto': produto.id,
      'codigo': produto.codigo,
      'nome': produto.nome,
    };
  }
}
