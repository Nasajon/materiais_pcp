import 'package:pcp_flutter/app/modules/roteiro/domain/entities/produto_entity.dart';

abstract class GetProdutoRepository {
  Future<List<ProdutoEntity>> call(String search);
}
