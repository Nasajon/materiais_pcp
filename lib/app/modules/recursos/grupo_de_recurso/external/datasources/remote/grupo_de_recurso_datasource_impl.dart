import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:nsj_flutter_login/nsj_login.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/common/external/mapper/remote/grupo_de_recurso_mapper.dart';

import '../../../domain/errors/grupo_de_recursos_failures.dart';
import '../../../infra/datasources/remote/grupo_de_recurso_datasource.dart';

class GrupoDeRecursoDatasourceImpl implements GrupoDeRecursoDatasource {
  final IClientService clientService;

  GrupoDeRecursoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<GrupoDeRecurso>> getList(String? search) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'tipo'};

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/1234/gruposderecursos',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      return (response.data as List).map((e) => GrupoDeRecursoMapper.fromMap(e)).toList();
    } on Failure catch (e) {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRecursoDatasourceImpl-getList'));
    }
  }

  @override
  Future<GrupoDeRecurso> getItem(String id) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'tipo'};

      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/1234/gruposderecursos/$id',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      return GrupoDeRecursoMapper.fromMap(response.data);
    } on ClientError catch (e) {
      if (e.statusCode == 404) {
        throw GrupoDeRecursoNotFound();
      }

      rethrow;
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRecursoDatasourceImpl-getItem'));
    }
  }

  @override
  Future<GrupoDeRecurso> insertItem(GrupoDeRecurso grupoDeRecurso) async {
    try {
      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/1234/gruposderecursos',
        method: ClientRequestMethods.POST,
        body: GrupoDeRecursoMapper.toMap(grupoDeRecurso),
        interceptors: interceptors,
      ));

      return GrupoDeRecursoMapper.fromMap(response.data);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRecursoDatasourceImpl-insertItem'));
    }
  }

  @override
  Future<GrupoDeRecurso> updateItem(GrupoDeRecurso grupoDeRecurso) async {
    try {
      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/1234/gruposderecursos/${grupoDeRecurso.id!}',
        method: ClientRequestMethods.PUT,
        body: GrupoDeRecursoMapper.toMap(grupoDeRecurso),
        interceptors: interceptors,
      ));

      if (response.statusCode == 404) {
        throw GrupoDeRecursoNotFound();
      }

      return GrupoDeRecursoMapper.fromMap(response.data);
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRecursoDatasourceImpl-updateItem'));
    }
  }

  @override
  Future<bool> deleteItem(String id) async {
    try {
      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/1234/gruposderecursos/$id',
        method: ClientRequestMethods.DELETE,
        interceptors: interceptors,
      ));

      if (response.statusCode == 404) {
        throw GrupoDeRecursoNotFound();
      }

      return true;
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRecursoDatasourceImpl-updateItem'));
    }
  }
}
