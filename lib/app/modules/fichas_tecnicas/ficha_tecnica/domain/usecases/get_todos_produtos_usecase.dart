import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/produto_repository.dart';

abstract class GetTodosProdutosUsecase {
  Future<List<ProdutoEntity>> call(String search);
}

class GetTodosProdutosUsecaseImpl implements GetTodosProdutosUsecase {
  final ProdutoRepository _produtoRepository;

  GetTodosProdutosUsecaseImpl(this._produtoRepository);

  @override
  Future<List<ProdutoEntity>> call(String search) {
    return _produtoRepository.getTodosProdutos(search);
  }
}
