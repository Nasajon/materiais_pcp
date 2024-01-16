import 'package:pcp_flutter/app/modules/roteiro/domain/entities/produto_entity.dart';

abstract class RemoteGetProdutoDatasource {
  Future<List<ProdutoEntity>> call(String search);
}
