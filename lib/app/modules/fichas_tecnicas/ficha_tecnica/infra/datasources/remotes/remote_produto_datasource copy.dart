import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';

abstract class RemoteProdutoDatasource {
  Future<List<ProdutoEntity>> getTodosProdutos(String search);

  Future<Map<String, ProdutoEntity>> getTodosProdutosPorIds(List<String> ids);

  Future<ProdutoEntity> getProdutoPorId(String id);
}