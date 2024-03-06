import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_material_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_unidade_mapper.dart';

class RemoteChaoDeFabricaMaterialMapper {
  const RemoteChaoDeFabricaMaterialMapper._();

  static ChaoDeFabricaMaterialEntity fromMapToMaterialEntity(Map<String, dynamic> map) {
    return ChaoDeFabricaMaterialEntity(
      id: map['produto_atividade'],
      atividadeRecursoId: map['atividade_recurso'],
      produto: RemoteChaoDeFabricaProdutoMapper.fromMapToProdutoEntity(map['produto']),
      unidade: RemoteChaoDeFabricaUnidadeMapper.fromMapToUnidadeEntity(map['unidade']),
      quantidade: DoubleVO(map['quantidade']),
      quantidadeUtilizada: DoubleVO(map['quantidade_utilizada']),
      quantidadePerda: DoubleVO(map['quantidade_perda']),
      quantidadeSobra: DoubleVO(map['quantidade_sobra']),
    );
  }
}
