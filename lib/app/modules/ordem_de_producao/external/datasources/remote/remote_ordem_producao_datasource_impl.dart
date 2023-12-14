import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_ordem_de_producao_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_ordem_de_producao_datasource.dart';

class RemoteOrdemDeProducaoDatasourceImpl implements RemoteOrdemDeProducaoDatasource {
  final IClientService _clientService;

  RemoteOrdemDeProducaoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<OrdemDeProducaoAggregate>> getOrdens({String search = '', String ultimoId = '', String? status}) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'fim,roteiro.unidade,produto,cliente'};

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (ultimoId.isNotEmpty) {
        queryParams['after'] = ultimoId;
      }
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/ordensdeproducoes',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      final data = List.from(response.data).map((map) => RemoteOrdemDeProducaoMapper.fromMapToOrdemDeProducaoAggregate(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceOrdemDeProducaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<OrdemDeProducaoAggregate> getOrdemDeProducaoPorId(String ordemDeProducaoId) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'fim,roteiro.unidade,produto,cliente'};

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/ordensdeproducoes/$ordemDeProducaoId',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      final data = RemoteOrdemDeProducaoMapper.fromMapToOrdemDeProducaoAggregate(response.data);

      return data;
    } on ClientError catch (e) {
      throw DatasourceOrdemDeProducaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> aprovarOrdemDeProducao(String ordemDeProducaoId) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/ordensdeproducoes/$ordemDeProducaoId/aprovar',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      return true;
    } on ClientError catch (e) {
      throw DatasourceOrdemDeProducaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<OrdemDeProducaoAggregate> inserir(OrdemDeProducaoAggregate ordemDeProducao) async {
    try {
      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/ordensdeproducoes',
          method: ClientRequestMethods.POST,
          interceptors: interceptors,
          body: RemoteOrdemDeProducaoMapper.fromOrdemDeProducaoToMap(ordemDeProducao),
        ),
      );

      return ordemDeProducao.copyWith(id: response.data['ordem_de_producao']);
    } on ClientError catch (e) {
      throw DatasourceOrdemDeProducaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> atualizar(OrdemDeProducaoAggregate ordemDeProducao) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/ordensdeproducoes/${ordemDeProducao.id}',
          method: ClientRequestMethods.PUT,
          interceptors: interceptors,
          body: RemoteOrdemDeProducaoMapper.fromOrdemDeProducaoToMap(ordemDeProducao),
        ),
      );

      return true;
    } on ClientError catch (e) {
      throw DatasourceOrdemDeProducaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> deletar(String ordemDeProducaoId) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/ordensdeproducoes/$ordemDeProducaoId',
          method: ClientRequestMethods.DELETE,
          interceptors: interceptors,
        ),
      );

      return true;
    } on ClientError catch (e) {
      throw DatasourceOrdemDeProducaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
