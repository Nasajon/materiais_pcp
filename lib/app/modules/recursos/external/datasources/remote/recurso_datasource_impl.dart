import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:nsj_flutter_login/nsj_login.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';

import '../../../../grupo_de_recurso/domain/errors/grupo_de_recursos_failures.dart';
import '../../../domain/entities/recurso.dart';
import '../../../domain/errors/recurso_failures.dart';
import '../../../infra/datasources/remote/recurso_datasource.dart';
import '../../mappers/remote/recurso_mapper.dart';

class RecursoDatasourceImpl implements RecursoDatasource {
  final IClientService clientService;

  RecursoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  Map<String, dynamic> queryParams = {'fields': 'grupo_de_recurso, centro_de_trabalho, turnos.turno'};

  @override
  Future<List<Recurso>> getList(String? search) async {
    try {
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/recursos',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      return (response.data as List).map((e) => RecursoMapper.fromMap(e)).toList();
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'RecursoDatasourceImpl-getList'));
    }
  }

  @override
  Future<List<Recurso>> getRecursoRecente() async {
    try {
      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/recursos',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      return (response.data as List).map((e) => RecursoMapper.fromMap(e)).toList();
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'RecursoDatasourceImpl-getList'));
    }
  }

  @override
  Future<Recurso> getItem(String id) async {
    try {
      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/recursos/$id',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      if (response.statusCode == 404) {
        throw RecursoNotFound();
      }

      final recursoMap = response.data;

      // if (recursoMap['grupo_de_recurso'] != null) {
      //   recursoMap['grupo_de_recurso'] = await _getGrupoDeRecursoById(recursoMap['grupo_de_recurso']);
      // }

      return RecursoMapper.fromMap(recursoMap);
    } on ClientError catch (e) {
      throw DatasourceRecursoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<Recurso> insertItem(Recurso recurso) async {
    try {
      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/recursos',
        method: ClientRequestMethods.POST,
        body: RecursoMapper.toMap(recurso),
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      recurso = recurso.copyWith(id: response.data['recurso']);

      return recurso;
    } on ClientError catch (e) {
      throw DatasourceRecursoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<Recurso> updateItem(Recurso recurso) async {
    try {
      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/recursos/${recurso.id!}',
        method: ClientRequestMethods.PUT,
        body: RecursoMapper.toMap(recurso),
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      if (response.statusCode == 404) {
        throw RecursoNotFound();
      }

      return recurso;
    } on ClientError catch (e) {
      throw DatasourceRecursoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  Future<Map<String, dynamic>> _getGrupoDeRecursoById(String id) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'tipo'};

      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/gruposderecursos/$id',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      if (response.statusCode == 404) {
        throw GrupoDeRecursoNotFound();
      }

      return response.data;
    } on ClientError catch (e) {
      throw DatasourceRecursoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> deleteItem(String id) async {
    try {
      await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/recursos/$id',
        method: ClientRequestMethods.DELETE,
        interceptors: interceptors,
      ));

      return true;
    } on ClientError catch (e) {
      throw DatasourceRecursoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
