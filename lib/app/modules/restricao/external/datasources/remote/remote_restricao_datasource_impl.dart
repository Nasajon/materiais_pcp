import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/error/restricao_failure.dart';
import 'package:pcp_flutter/app/modules/restricao/external/mapper/remote/remote_indisponibilidade_mapper.dart';
import 'package:pcp_flutter/app/modules/restricao/external/mapper/remote/remote_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/datasources/remote/remote_restricao_datasource.dart';

class RemoteRestricaoDatasourceImpl implements RemoteRestricaoDatasource {
  final IClientService _clientService;

  RemoteRestricaoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<RestricaoAggregate>> getRestricaoRecente([String? search]) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'grupo_de_restricao, centro_de_trabalho, turnos.turno'};

      final response = await _clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/restricoes',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      return List.from(response.data).map((map) => RemoteRestricaoMapper.fromMapToRestricaoAggregate(map)).toList();
    } on ClientError catch (e) {
      throw DatasourceRestricaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<List<RestricaoAggregate>> getList([String? search]) async {
    Map<String, dynamic> queryParams = {'fields': 'grupo_de_restricao, centro_de_trabalho, turnos.turno'};

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    final response = await _clientService.request(ClientRequestParams(
      selectedApi: APIEnum.pcp,
      endPoint: '/restricoes',
      method: ClientRequestMethods.GET,
      queryParams: queryParams,
      interceptors: interceptors,
    ));

    return List.from(response.data).map((map) => RemoteRestricaoMapper.fromMapToRestricaoAggregate(map)).toList();
  }

  @override
  Future<RestricaoAggregate> getRestricaoPorId(String id) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'grupo_de_restricao, indisponibilidades, centro_de_trabalho, turnos.turno'};

      final response = await _clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/restricoes/$id',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      final restricao = RemoteRestricaoMapper.fromMapToRestricaoAggregate(response.data);

      return restricao.copyWith(
          indisponibilidades: RemoteIndisponibilidadeMapper.setarIndexParaOsIndisponibilidades(restricao.indisponibilidades));
    } on ClientError catch (e) {
      throw DatasourceRestricaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<RestricaoAggregate> insert(RestricaoAggregate restricao) async {
    try {
      final response = await _clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/restricoes',
        method: ClientRequestMethods.POST,
        interceptors: interceptors,
        body: RemoteRestricaoMapper.fromRestricaoAggregateToMap(restricao),
      ));

      return restricao.copyWith(id: response.data['restricao']);
    } on ClientError catch (e) {
      throw DatasourceRestricaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> update(RestricaoAggregate restricao) async {
    try {
      await _clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/restricoes/${restricao.id}',
        method: ClientRequestMethods.PUT,
        interceptors: interceptors,
        body: RemoteRestricaoMapper.fromRestricaoAggregateToMap(restricao),
      ));

      return true;
    } on ClientError catch (e) {
      throw DatasourceRestricaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      await _clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/restricoes/$id',
        method: ClientRequestMethods.DELETE,
        interceptors: interceptors,
      ));

      return true;
    } on ClientError catch (e) {
      throw DatasourceRestricaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
