import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_unidade_mapper.dart';

class RemoteMaterialMapper {
  const RemoteMaterialMapper._();

  static MaterialEntity fromMapToMaterialEntity(Map<String, dynamic> map) {
    return MaterialEntity(
      fichaTecnicaId: map['ficha_tecnica_produto'],
      produto: RemoteProdutoMapper.fromMapToProdutoEntity(map['produto']),
      unidade: RemoteUnidadeMapper.fromMapToUnidadeEntity(map['unidade']),
      disponivel: DoubleVO(map['quantidade']),
      quantidade: DoubleVO(0),
    );
  }

  static MaterialEntity fromMapToMaterial(Map<String, dynamic> map) {
    return MaterialEntity(
      id: map['produto_operacao'],
      fichaTecnicaId: map['ficha_tecnica_produto'],
      produto: RemoteProdutoMapper.fromMapToProdutoEntity(map['produto']),
      unidade: RemoteUnidadeMapper.fromMapToUnidadeEntity(map['unidade']),
      disponivel: DoubleVO(map['disponivel']),
      quantidade: DoubleVO(map['quantidade']),
    );
  }

  static Map<String, dynamic> fromMaterialToMap(MaterialEntity material) {
    final map = {
      'ficha_tecnica_produto': material.fichaTecnicaId,
      'produto': material.produto.id,
      'unidade': material.unidade.id,
      'disponivel': material.disponivel.value,
      'quantidade': material.quantidade.value,
      'tipo_produto': 'insumo', // TODO: Mudar na nova versão do roteiro
      'tipo_produto_operacao': 'material_ficha_tecnica', // TODO: Mudar na nova versão do roteiro
    };

    if (material.id != null && material.id!.isNotEmpty) {
      map['produto_operacao'] = material.id ?? '';
    }

    return map;
  }
}
