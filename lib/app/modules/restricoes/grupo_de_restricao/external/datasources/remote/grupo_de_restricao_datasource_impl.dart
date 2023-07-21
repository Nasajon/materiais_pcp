import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:nsj_flutter_login/nsj_login.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/external/mapper/remote/grupo_de_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/errors/grupo_de_restricao_failures.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/infra/datasources/remote/grupo_de_restricao_datasource.dart';

class GrupoDeRestricaoDatasourceImpl implements GrupoDeRestricaoDatasource {
  final IClientService clientService;

  GrupoDeRestricaoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<GrupoDeRestricaoEntity>> getList(String? search) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'tipo'};

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/1234/gruposderestricoes',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      return (response.data as List).map((e) => GrupoDeRestricaoMapper.fromMapToGrupoDeRestricaoEntity(e)).toList();
    } on Failure catch (e) {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRestricaoDatasourceImpl-getList'));
    }
  }

  @override
  Future<GrupoDeRestricaoEntity> getItem(String id) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'tipo'};

      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/1234/gruposderestricoes/$id',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      return GrupoDeRestricaoMapper.fromMapToGrupoDeRestricaoEntity(response.data);
    } on ClientError catch (e) {
      if (e.statusCode == 404) {
        throw GrupoDeRestricaoNotFound();
      }

      rethrow;
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRestricaoDatasourceImpl-getItem'));
    }
  }

  @override
  Future<GrupoDeRestricaoEntity> insertItem(GrupoDeRestricaoEntity grupoDeRestricao) async {
    try {
      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/1234/gruposderestricoes',
        method: ClientRequestMethods.POST,
        body: GrupoDeRestricaoMapper.fromGrupoDeRestricaoEntityToMap(grupoDeRestricao),
        interceptors: interceptors,
      ));

      return GrupoDeRestricaoMapper.fromMapToGrupoDeRestricaoEntity(response.data);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRestricaoDatasourceImpl-insertItem'));
    }
  }

  @override
  Future<GrupoDeRestricaoEntity> updateItem(GrupoDeRestricaoEntity grupoDeRestricao) async {
    try {
      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/1234/gruposderestricoes/${grupoDeRestricao.id!}',
        method: ClientRequestMethods.PUT,
        body: GrupoDeRestricaoMapper.fromGrupoDeRestricaoEntityToMap(grupoDeRestricao),
        interceptors: interceptors,
      ));

      if (response.statusCode == 404) {
        throw GrupoDeRestricaoNotFound();
      }

      return GrupoDeRestricaoMapper.fromMapToGrupoDeRestricaoEntity(response.data);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRestricaoDatasourceImpl-updateItem'));
    }
  }

  @override
  Future<bool> deletarItem(String id) async {
    try {
      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/1234/gruposderestricoes/$id',
        method: ClientRequestMethods.DELETE,
        interceptors: interceptors,
      ));

      return true;
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRestricaoDatasourceImpl-updateItem'));
    }
  }
}
