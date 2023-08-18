import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_unidade_mapper.dart';

class RemoteMaterialMapper {
  const RemoteMaterialMapper._();

  static MaterialEntity fromMapToMaterialEntity(Map<String, dynamic> map) {
    return MaterialEntity(
      fichaTecnicaId: map['ficha_tecnica_produto'],
      produto: ProdutoEntity.id(map['produto']),
      unidade: UnidadeEntity.id(map['unidade']),
      disponivel: map['quantidade'],
      quantidade: 0,
    );
  }

  static MaterialEntity fromMapToMaterial(Map<String, dynamic> map) {
    return MaterialEntity(
      id: map['produto_operacao'],
      fichaTecnicaId: map['ficha_tecnica_produto'],
      produto: RemoteProdutoMapper.fromMapToProdutoEntity(map['produto']),
      unidade: RemoteUnidadeMapper.fromMapToUnidadeEntity(map['unidade']),
      disponivel: map['disponivel'],
      quantidade: map['quantidade'],
    );
  }

  static Map<String, dynamic> fromMaterialToMap(MaterialEntity material) {
    return {
      'produto_operacao': material.id,
      'ficha_tecnica_produto': material.fichaTecnicaId,
      'produto': material.produto.id,
      'unidade': material.unidade.id,
      'disponivel': material.disponivel,
      'quantidade': material.quantidade,
    };
  }
}
