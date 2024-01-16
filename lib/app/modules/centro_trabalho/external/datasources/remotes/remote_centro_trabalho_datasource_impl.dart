import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/external/mappers/remotes/remote_centro_trabalho_mapper.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/external/mappers/remotes/remote_turno_trabanho_mappers.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/infra/datasources/remotes/remote_centro_trabalho_datasource.dart';

class RemoteCentroTrabalhoDatasourceImpl implements RemoteCentroTrabalhoDatasource {
  final IClientService clientService;

  RemoteCentroTrabalhoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<CentroTrabalhoAggregate>> getCentroTrabalhoRecentes() async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/centrosdetrabalhos',
          // endPoint: '/centrosdetrabalhos/recents',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          body: <String, dynamic>{},
        ),
      );

      final data = List.from(response.data).map((map) => RemoteCentroTrabalhoMapper.fromMapToCentroTrabalho(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceCentroTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<List<CentroTrabalhoAggregate>> getTodosCentroTrabalho(String search) async {
    Map<String, dynamic> queryParams = {};

    if (search.isNotEmpty) {
      queryParams['search'] = search;
    }

    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/centrosdetrabalhos',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
          body: <String, dynamic>{},
        ),
      );

      final data = List.from(response.data).map((map) => RemoteCentroTrabalhoMapper.fromMapToCentroTrabalho(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceCentroTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<CentroTrabalhoAggregate> getCentroTrabalhoPorId(String id) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/centrosdetrabalhos/$id?fields=turnos.turno',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      final data = RemoteCentroTrabalhoMapper.fromMapToCentroTrabalho(response.data);

      return data;
    } on ClientError catch (e) {
      throw DatasourceCentroTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<List<TurnoTrabalhoEntity>> getTurnos(String id, List<String> turnosId) async {
    var turnosParams = '';

    turnosId.forEach((element) => turnosParams += '$element,');

    turnosParams = turnosParams.substring(0, turnosParams.length - 1).trimRight();

    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/turnos?turno=$turnosParams',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      final turnos = List.from(response.data).map((map) => RemoteTurnoTrabalhoMapper.fromMapToTurnoTrabalhoEntity(map)).toList();

      return turnos;
    } on ClientError catch (e) {
      throw DatasourceCentroTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<CentroTrabalhoAggregate> inserirCentroTrabalho(CentroTrabalhoAggregate centroTrabalho) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/centrosdetrabalhos',
          method: ClientRequestMethods.POST,
          interceptors: interceptors,
          body: RemoteCentroTrabalhoMapper.fromCentroTrabalhoToMap(centroTrabalho),
        ),
      );

      centroTrabalho = centroTrabalho.copyWith(id: response.data['centro_de_trabalho']);

      return centroTrabalho;
    } on ClientError catch (e) {
      throw DatasourceCentroTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<bool> atualizarCentroTrabalho(CentroTrabalhoAggregate centroTrabalho) async {
    try {
      await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/centrosdetrabalhos/${centroTrabalho.id}',
          method: ClientRequestMethods.PUT,
          interceptors: interceptors,
          body: RemoteCentroTrabalhoMapper.fromCentroTrabalhoToMap(centroTrabalho),
        ),
      );

      return true;
    } on ClientError catch (e) {
      throw DatasourceCentroTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<bool> deletarCentroTrabalho(String id) async {
    try {
      await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/centrosdetrabalhos/$id',
          method: ClientRequestMethods.DELETE,
          interceptors: interceptors,
        ),
      );

      return true;
    } on ClientError catch (e) {
      throw DatasourceCentroTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }
}
