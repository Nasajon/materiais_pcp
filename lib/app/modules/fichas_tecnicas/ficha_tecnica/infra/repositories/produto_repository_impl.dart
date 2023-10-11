import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/produto_repository.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_produto_datasource%20copy.dart';

class ProdutoRepositoryImpl implements ProdutoRepository {
  final RemoteProdutoDatasource remoteProdutoDatasource;

  ProdutoRepositoryImpl(this.remoteProdutoDatasource);

  @override
  Future<List<ProdutoEntity>> getTodosProdutos(String search) {
    return remoteProdutoDatasource.getTodosProdutos(search);
  }

  @override
  Future<Map<String, ProdutoEntity>> getTodosProdutosPorIds(List<String> ids) {
    return remoteProdutoDatasource.getTodosProdutosPorIds(ids);
  }
}
