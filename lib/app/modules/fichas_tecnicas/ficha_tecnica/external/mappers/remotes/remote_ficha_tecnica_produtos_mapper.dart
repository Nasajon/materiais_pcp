import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_produto_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_unidade_mapper.dart';

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

  static Map<String, dynamic> fromFichaTecnicaProdutoToMap(FichaTecnicaMaterialAggregate fichaTecnica) {
    return {
      'produto': fichaTecnica.produto.id,
      'quantidade': fichaTecnica.quantidade.value.toString(),
      'unidade': fichaTecnica.unidade.id,
    };
  }
}
