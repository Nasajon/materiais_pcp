import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/external/mapper/remote/remote_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/infra/datasources/remote/remote_restricao_datasource.dart';

class RemoteRestricaoDatasourceImpl implements RemoteRestricaoDatasource {
  final IClientService _clientService;

  RemoteRestricaoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<RestricaoAggregate>> getList([String? search]) async {
    Map<String, dynamic> queryParams = {'fields': 'tipo'};

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    // final response = await _clientService.request(ClientRequestParams(
    //   selectedApi: APIEnum.pcp,
    //   endPoint: '/1234/restricoes',
    //   method: ClientRequestMethods.GET,
    //   queryParams: queryParams,
    //   interceptors: interceptors,
    // ));

    // final listRestricao = response.data;

    final listRestricao = json;

    return (listRestricao).map((map) => RemoteRestricaoMapper.fromMapToRestricaoAggregate(map)).toList();
  }

  @override
  Future<RestricaoAggregate> getRestricaoPorId(String id) async {
    final listRestricao = json;

    final restricao = (listRestricao).map((map) => RemoteRestricaoMapper.fromMapToRestricaoAggregate(map)).toList().first;

    return restricao;
  }

  @override
  Future<RestricaoAggregate> insert(RestricaoAggregate restricao) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<bool> update(RestricaoAggregate restricao) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

final json = [
  {
    'restricao': '123',
    'codigo': '1',
    'descricao': 'Restrição 1',
    'grupo': {
      "grupo_de_restricao": "64705ab6-f02e-40d4-967d-06751bd1fc9e",
      "codigo": "01",
      "descricao": "Teste",
      "tipo": "ferramenta",
      "tenant": 47
    },
    'tipo_unidade': 'decimetro_cubico',
    'capacidade_producao': 2,
    'custo_por_hora': 20.0,
    'limitar_capacidade_producao': false,
    'indisponibilidades': <Map<String, dynamic>>[],
    'disponibilidades': <Map<String, dynamic>>[],
  },
  {
    'restricao': '1234',
    'codigo': '2',
    'descricao': 'Restrição 2',
    'grupo': {
      "grupo_de_restricao": "64705ab6-f02e-40d4-967d-06751bd1fc9e",
      "codigo": "01",
      "descricao": "Teste",
      "tipo": "ferramenta",
      "tenant": 47
    },
    'tipo_unidade': 'decimetro_cubico',
    'capacidade_producao': 2,
    'custo_por_hora': 20.0,
    'limitar_capacidade_producao': false,
    'indisponibilidades': <Map<String, dynamic>>[],
    'disponibilidades': <Map<String, dynamic>>[],
  }
];
