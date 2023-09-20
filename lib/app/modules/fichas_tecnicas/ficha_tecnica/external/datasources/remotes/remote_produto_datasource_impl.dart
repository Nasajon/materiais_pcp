import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/produto_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_produto_datasource%20copy.dart';

class RemoteProdutoDatasourceImpl implements RemoteProdutoDatasource {
  final IClientService clientService;

  RemoteProdutoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<ProdutoEntity> getProdutoPorId(String id) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/produtos/$id',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );
      return RemoteProdutoMapper.fromMapToProduto(response.data);
    } on ClientError catch (e) {
      throw DatasourceProdutoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<List<ProdutoEntity>> getTodosProdutos(String search) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/produtos${search.trim() == '' ? '' : '?search=$search'}',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      var data = List.from(response.data).map((map) => RemoteProdutoMapper.fromMapToProduto(map)).toList();
      return data;
    } on ClientError catch (e) {
      throw DatasourceProdutoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<Map<String, ProdutoEntity>> getTodosProdutosPorIds(List<String> ids) async {
    if (ids.isEmpty) {
      return {};
    }

    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/produtos?produto=${ids.join(',')}',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      var data = List.from(response.data).map((map) => RemoteProdutoMapper.fromMapToProduto(map));
      if (data.isEmpty) {
        return {};
      }
      return {for (var v in data) v.id: v};
    } on ClientError catch (e) {
      throw DatasourceProdutoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }
}
