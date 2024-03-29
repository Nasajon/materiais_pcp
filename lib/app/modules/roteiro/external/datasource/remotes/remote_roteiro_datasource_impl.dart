import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_roteiro_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_roteiro_datasource.dart';

class RemoteRoteiroDatasourceImpl implements RemoteRoteiroDatasource {
  final IClientService _clientService;

  RemoteRoteiroDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<RoteiroEntity>> getRoteiroRecente() async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'produto_resultante'};

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/roteiros',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      final data = List.from(response.data).map((map) => RemoteRoteiroMapper.fromMapToRoteiroEntity(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<List<RoteiroEntity>> getRoteiro(String search) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'produto_resultante'};

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/roteiros',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      final data = List.from(response.data).map((map) => RemoteRoteiroMapper.fromMapToRoteiroEntity(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<RoteiroAggregate> getRoteiroPeloId(String roteiroId) async {
    try {
      Map<String, dynamic> queryParams = {
        'fields':
            'inicio,fim,ficha_tecnica,produto_resultante,unidade,operacoes.produto_resultante,operacoes.unidade,operacoes.produtos,operacoes.centro_de_trabalho,operacoes.produtos.produto,operacoes.produtos.unidade,operacoes.grupos_recursos.grupo_de_recurso,operacoes.grupos_recursos.recursos.recurso, operacoes.grupos_recursos.recursos.grupos_restricoes.grupo_de_restricao,operacoes.grupos_recursos.recursos.grupos_restricoes.unidade,operacoes.grupos_recursos.recursos.grupos_restricoes.restricoes.restricao,operacoes.grupos_recursos.recursos.grupos_restricoes.restricoes.unidade'
      };

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/roteiros/$roteiroId',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      return RemoteRoteiroMapper.fromMapToRoteiroAggregate(response.data);
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<String> inserirRoteiro(RoteiroAggregate roteiro) async {
    try {
      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/roteiros',
          method: ClientRequestMethods.POST,
          interceptors: interceptors,
          body: RemoteRoteiroMapper.fromRoteiroToMap(roteiro),
        ),
      );

      return response.data['roteiro'];
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> editarRoteiro(RoteiroAggregate roteiro) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/roteiros/${roteiro.id}',
          method: ClientRequestMethods.PUT,
          interceptors: interceptors,
          body: RemoteRoteiroMapper.fromRoteiroToMap(roteiro),
        ),
      );

      return true;
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> deletarRoteiro(String roteiroId) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/roteiros/$roteiroId',
          method: ClientRequestMethods.DELETE,
          interceptors: interceptors,
        ),
      );

      return true;
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
