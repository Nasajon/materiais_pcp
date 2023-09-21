import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_ficha_tecnica_produtos_mapper.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_unidade_mapper.dart';

class RemoteFichaTecnicaMapper {
  const RemoteFichaTecnicaMapper._();

  static FichaTecnicaAggregate fromMapToFichaTecnica(Map<String, dynamic> map) {
    return FichaTecnicaAggregate(
      id: map['ficha_tecnica'],
      quantidade: MoedaVO(map['quantidade']),
      descricao: TextVO(map['descricao']),
      produto: RemoteProdutoMapper.fromMapToProduto(map['produto']),
      codigo: TextVO(map['codigo']),
      unidade: RemoteUnidadeMapper.fromMapToUnidade(map['unidade']),
      materiais: map.containsKey('produtos')
          ? List.from(map['produtos'])
              .asMap()
              .entries
              .map((entry) => RemoteFichaTecnicaProdutosMapper.fromMapToFichaTecnicaProduto(entry.value, entry.key))
              .toList()
          : [],
    );
  }

  static Map<String, dynamic> fromFichaTecnicaToMap(FichaTecnicaAggregate fichaTecnica) {
    return {
      'unidade': fichaTecnica.unidade!.id,
      'produto': fichaTecnica.produto!.id,
      'descricao': fichaTecnica.descricao.value,
      'codigo': fichaTecnica.codigo.value,
      'quantidade': fichaTecnica.quantidade.value!.toDouble(),
      'produtos': fichaTecnica.materiais.map((produto) => RemoteFichaTecnicaProdutosMapper.fromFichaTecnicaProdutoToMap(produto)).toList(),
    };
  }
}
