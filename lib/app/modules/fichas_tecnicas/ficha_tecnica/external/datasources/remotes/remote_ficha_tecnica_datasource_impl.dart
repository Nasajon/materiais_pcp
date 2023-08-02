import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_ficha_tecnica_mapper.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_ficha_tecnica_datasource.dart';

class RemoteFichaTecnicaDatasourceImpl implements RemoteFichaTecnicaDatasource {
  final IClientService clientService;

  RemoteFichaTecnicaDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<bool> atualizarFichaTecnica(FichaTecnicaAggregate fichaTecnica) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
            selectedApi: APIEnum.pcp,
            endPoint: '/1234/fichastecnicas/${fichaTecnica.id}',
            method: ClientRequestMethods.PUT,
            interceptors: interceptors,
            body: RemoteFichaTecnicaMapper.fromFichaTecnicaToMap(fichaTecnica)),
      );

      return true;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> deletarFichaTecnica(String id) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/fichastecnicas/$id',
          method: ClientRequestMethods.DELETE,
          interceptors: interceptors,
        ),
      );
      return true;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<FichaTecnicaAggregate> getFichaTecnicaPorId(String id) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/fichastecnicas/$id?fields=produtos',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );
      return RemoteFichaTecnicaMapper.fromMapToFichaTecnica(response.data);
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<List<FichaTecnicaAggregate>> getFichaTecnicaRecentes() async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/fichastecnicas',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      final data = List.from(response.data).map((map) => RemoteFichaTecnicaMapper.fromMapToFichaTecnica(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<List<FichaTecnicaAggregate>> getTodosFichaTecnica(String search) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/fichastecnicas${search.trim() == '' ? '' : '?search=$search'}',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      final data = List.from(response.data).map((map) => RemoteFichaTecnicaMapper.fromMapToFichaTecnica(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<FichaTecnicaAggregate> inserirFichaTecnica(FichaTecnicaAggregate fichaTecnica) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/fichastecnicas',
          method: ClientRequestMethods.POST,
          interceptors: interceptors,
          body: RemoteFichaTecnicaMapper.fromFichaTecnicaToMap(fichaTecnica),
        ),
      );

      fichaTecnica = fichaTecnica.copyWith(id: response.data['ficha_tecnica']);

      return fichaTecnica;
    } on ClientError catch (e) {
      throw DatasourceFichaTecnicaFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }
}
