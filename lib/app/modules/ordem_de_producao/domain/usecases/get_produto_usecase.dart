import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_produto_repository.dart';

abstract interface class GetProdutoUsecase {
  Future<List<ProdutoEntity>> call({String search = '', String ultimoId = ''});
}

class GetProdutoUsecaseImpl implements GetProdutoUsecase {
  final GetProdutoRepository _getProdutoRepository;

  const GetProdutoUsecaseImpl(this._getProdutoRepository);

  @override
  Future<List<ProdutoEntity>> call({String search = '', String ultimoId = ''}) {
    return _getProdutoRepository(search: search, ultimoId: ultimoId);
  }
}
