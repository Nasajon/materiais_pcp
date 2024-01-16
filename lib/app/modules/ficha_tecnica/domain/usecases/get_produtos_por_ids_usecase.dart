import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/produto_repository.dart';

abstract class GetProdutosPorIdsUsecase {
  Future<Map<String, ProdutoEntity>> call(List<String> ids);
}

class GetProdutosPorIdsUsecaseImpl implements GetProdutosPorIdsUsecase {
  final ProdutoRepository _produtoRepository;

  const GetProdutosPorIdsUsecaseImpl(this._produtoRepository);

  @override
  Future<Map<String, ProdutoEntity>> call(List<String> ids) {
    return _produtoRepository.getTodosProdutosPorIds(ids);
  }
}
