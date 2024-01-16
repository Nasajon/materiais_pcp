import 'package:pcp_flutter/app/modules/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_produto_repository.dart';

abstract class GetProdutoUsecase {
  Future<List<ProdutoEntity>> call(String search);
}

class GetProdutoUsecaseImpl implements GetProdutoUsecase {
  final GetProdutoRepository _getProdutoRepository;

  const GetProdutoUsecaseImpl(this._getProdutoRepository);

  @override
  Future<List<ProdutoEntity>> call(String search) {
    return _getProdutoRepository(search);
  }
}
