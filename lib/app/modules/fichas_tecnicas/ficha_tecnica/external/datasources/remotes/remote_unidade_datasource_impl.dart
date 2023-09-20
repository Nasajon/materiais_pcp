import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/unidade_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_unidade_mapper.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_unidade_datasource.dart';

class RemoteUnidadeDatasourceImpl implements RemoteUnidadeDatasource {
  final IClientService clientService;

  RemoteUnidadeDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<UnidadeEntity> getUnidadePorId(String id) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/unidades/$id',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );
      return RemoteUnidadeMapper.fromMapToUnidade(response.data);
    } on ClientError catch (e) {
      throw DatasourceUnidadeFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<List<UnidadeEntity>> getTodasUnidades(String search) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/unidades${search.trim() == '' ? '' : '?search=$search'}',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      return List.from(response.data).map((map) => RemoteUnidadeMapper.fromMapToUnidade(map)).toList();
    } on ClientError catch (e) {
      throw DatasourceUnidadeFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<Map<String, UnidadeEntity>> getTodasUnidadesPorIds(List<String> ids) async {
    if (ids.isEmpty) {
      return {};
    }

    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/unidades?unidade=${ids.join(',')}',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
        ),
      );

      var data = List.from(response.data).map((map) => RemoteUnidadeMapper.fromMapToUnidade(map));
      if (data.isEmpty) {
        return {};
      }
      return {for (var v in data) v.id: v};
    } on ClientError catch (e) {
      throw DatasourceUnidadeFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }
}
