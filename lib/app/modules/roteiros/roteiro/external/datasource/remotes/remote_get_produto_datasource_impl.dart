import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_produto_datasource.dart';

class RemoteGetProdutoDatasourceImpl implements RemoteGetProdutoDatasource {
  final IClientService _clientService;

  RemoteGetProdutoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<ProdutoEntity>> call(String search) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }

      // final response = await _clientService.request(
      //   ClientRequestParams(
      //     selectedApi: APIEnum.dadosmestre,
      //     endPoint: '/4311/produtos',
      //     method: ClientRequestMethods.GET,
      //     interceptors: interceptors,
      //     queryParams: queryParams,
      //   ),
      // );

      final response = jsonMock;
      await Future.delayed(const Duration(seconds: 3));

      final data = List.from(response['result'])
          .map((map) => RemoteProdutoMapper.fromMapToProdutoEntity(map))
          .toList()
          .where((produto) => '${produto.codigo} - ${produto.nome}'.toLowerCase().contains(search.toLowerCase()))
          .toList();
      // final data = List.from(response.data['result']).map((map) => RemoteProdutoMapper.fromMapToProdutoEntity(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}

const jsonMock = <String, dynamic>{
  'next': null,
  'prev': null,
  'result': [
    {
      'id': '358c2657-00e1-48dc-8beb-5175d691bcdw',
      'codigo': '1',
      'especificacao': 'Produto 1',
      'unidade_padrao': 'fbf7ab8a-11d5-4170-99c6-ade99311b4ed',
      'ncm': '19059090'
    },
    {
      'id': '358c2657-00e1-48dc-8beb-5175d691bcre',
      'codigo': '2',
      'especificacao': 'Produto 2',
      'unidade_padrao': 'fbf7ab8a-11d5-4170-99c6-ade99311b4ed',
      'ncm': '19059090'
    },
    {
      'id': '358c2657-00e1-48dc-8beb-5175d691bcr1',
      'codigo': '3',
      'especificacao': 'Produto 3',
      'unidade_padrao': 'fbf7ab8a-11d5-4170-99c6-ade99311b4ed',
      'ncm': '19059090'
    },
    {
      'id': '358c2658-00e1-48dc-8beb-5175d691bcr1',
      'codigo': '4',
      'especificacao': 'Produto 4',
      'unidade_padrao': 'fbf7ab8a-11d5-4170-99c6-ade99311b4ed',
      'ncm': '19059090'
    },
  ]
};
