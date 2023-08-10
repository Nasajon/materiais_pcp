import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/tipo_unidade_entity.dart';

class RemoteMaterialMapper {
  const RemoteMaterialMapper._();

  static MaterialEntity fromMapToMaterialEntity(Map<String, dynamic> map) {
    return MaterialEntity(
      id: map['ficha_tecnica_produto'],
      produto: ProdutoEntity.id(map['produto']),
      unidade: TipoUnidadeEntity.id(map['unidade']),
      disponivel: map['quantidade'],
      quantidade: 0,
    );
  }
}
