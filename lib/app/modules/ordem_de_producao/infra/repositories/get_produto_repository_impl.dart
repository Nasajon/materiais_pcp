import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_produto_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_produto_datasource.dart';

class GetProdutoRepositoryImpl implements GetProdutoRepository {
  final RemoteGetProdutoDatasource _remoteGetProdutoDatasource;

  const GetProdutoRepositoryImpl(this._remoteGetProdutoDatasource);

  @override
  Future<List<ProdutoEntity>> call({String search = '', String ultimoId = ''}) {
    return _remoteGetProdutoDatasource(search: search, ultimoId: ultimoId);
  }
}
