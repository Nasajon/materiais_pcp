import 'package:pcp_flutter/app/modules/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_produto_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_produto_datasource.dart';

class GetProdutoRepositoryImpl implements GetProdutoRepository {
  final RemoteGetProdutoDatasource _remoteGetProdutoDatasource;

  const GetProdutoRepositoryImpl(this._remoteGetProdutoDatasource);

  @override
  Future<List<ProdutoEntity>> call(String search) {
    return _remoteGetProdutoDatasource(search);
  }
}
