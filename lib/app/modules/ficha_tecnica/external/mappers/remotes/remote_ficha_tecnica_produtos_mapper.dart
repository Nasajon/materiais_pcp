import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_produto_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/mappers/remotes/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/mappers/remotes/remote_unidade_mapper.dart';

class RemoteFichaTecnicaProdutosMapper {
  const RemoteFichaTecnicaProdutosMapper._();

  static FichaTecnicaMaterialAggregate fromMapToFichaTecnicaProduto(Map<String, dynamic> map, int? index) {
    return FichaTecnicaMaterialAggregate(
      id: map['ficha_tecnica_produto'],
      codigo: index == null ? 0 : index + 1,
      produto: RemoteProdutoMapper.fromMapToProduto(map['produto']),
      quantidade: DoubleVO(map['quantidade']),
      unidade: RemoteUnidadeMapper.fromMapToUnidade(map['unidade']),
    );
  }

  static Map<String, dynamic> fromFichaTecnicaProdutoToMap(FichaTecnicaMaterialAggregate fichaTecnicaProduto) {
    return {
      'ficha_tecnica_produto': fichaTecnicaProduto.id,
      'produto': fichaTecnicaProduto.produto.id,
      'quantidade': fichaTecnicaProduto.quantidade.value.toString(),
      'unidade': fichaTecnicaProduto.unidade.id,
    };
  }
}
