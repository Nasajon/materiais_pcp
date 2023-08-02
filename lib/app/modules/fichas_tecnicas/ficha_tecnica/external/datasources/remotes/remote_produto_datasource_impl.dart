import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_produto_datasource%20copy.dart';

class RemoteProdutoDatasourceImpl implements RemoteProdutoDatasource {
  final IClientService clientService;

  RemoteProdutoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];
  var produtosMock = [
    {"produto": "b03b2af6-6b6e-40ee-b020-e6f385d55398", "codigo": "01", "nome": "produto 1"},
    {"produto": "21d0d1fb-40f1-4c91-9581-7a40644bad9b", "codigo": "02", "nome": "produto 2"},
    {"produto": "e6aafbcd-2ab7-4c2d-a2c6-0a2899318382", "codigo": "03", "nome": "produto 3"},
    {"produto": "a2579099-1caf-4ba9-ba99-c8747c162dc9", "codigo": "04", "nome": "produto 4"},
    {"produto": "59331cb7-cd94-4ff6-ae12-d69db0265802", "codigo": "05", "nome": "produto 5"},
    {"produto": "a33bd64d-d9a6-4134-86ab-049e69d099f6", "codigo": "06", "nome": "produto 6"},
    {"produto": "484aef35-8560-41cc-b70f-a585cdae3b69", "codigo": "07", "nome": "produto 7"},
    {"produto": "6b10e6e1-802d-4c02-9ed6-692907fb33a8", "codigo": "08", "nome": "produto 8"},
    {"produto": "2231e1ed-e27e-41e9-9354-2a713bbe926c", "codigo": "09", "nome": "produto 9"},
  ];

  @override
  Future<ProdutoEntity> getProdutoPorId(String id) {
    var res = produtosMock.where((el) => el['produto'] == id).toList().map((map) => RemoteProdutoMapper.fromMapToProduto(map)).toList();
    if (res.length == 1) {
      return Future.value(res[0]);
    }
    throw ClientError(message: "Produto Not found");
  }

  @override
  Future<List<ProdutoEntity>> getTodosProdutos(String search) {
    return Future.value(produtosMock
        .where((el) =>
            (search == '') ||
            (el['codigo']?.toLowerCase() != null && el['codigo']!.contains(search.toLowerCase().trim())) ||
            (el['nome']?.toLowerCase() != null && el['nome']!.contains(search.toLowerCase().trim())))
        .toList()
        .map((map) => RemoteProdutoMapper.fromMapToProduto(map))
        .toList());
  }

  @override
  Future<Map<String, ProdutoEntity>> getTodosProdutosPorIds(List<String> ids) {
    var idSet = ids.toSet();
    var produtosList =
        produtosMock.where((el) => idSet.contains(el['produto'])).toList().map((map) => RemoteProdutoMapper.fromMapToProduto(map)).toList();
    var produtosMap = {for (var e in produtosList) e.id: e};
    if (produtosMap.isNotEmpty) {
      return Future.value(produtosMap);
    }
    throw ClientError(message: "Produtos Not found");
  }
}
