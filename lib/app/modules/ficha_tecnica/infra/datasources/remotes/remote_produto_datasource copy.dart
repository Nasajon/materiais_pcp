import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';

abstract class RemoteProdutoDatasource {
  Future<List<ProdutoEntity>> getTodosProdutos(String search);

  Future<Map<String, ProdutoEntity>> getTodosProdutosPorIds(List<String> ids);
}
