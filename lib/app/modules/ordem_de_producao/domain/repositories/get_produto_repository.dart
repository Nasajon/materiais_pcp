import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/produto_entity.dart';

abstract interface class GetProdutoRepository {
  Future<List<ProdutoEntity>> call({String search = '', String ultimoId = ''});
}
