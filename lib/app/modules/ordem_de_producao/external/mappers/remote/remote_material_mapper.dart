import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_unidade_mapper.dart';

class RemoteMaterialMapper {
  const RemoteMaterialMapper._();

  static MaterialEntity fromMapToMaterial(Map<String, dynamic> map) {
    return MaterialEntity(
      id: map['produto_operacao'],
      produto: RemoteProdutoMapper.fromMapToProdutoEntity(map['produto']),
      unidade: RemoteUnidadeMapper.fromMapToUnidadeEntity(map['unidade']),
      quantidade: DoubleVO(map['quantidade']),
    );
  }
}
