import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricao/external/mapper/remote/restricao_grupo_de_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/datasources/remote/remote_get_grupo_de_restricao_datasource.dart';

class RemoteGetGrupoDeRestricaoDatasourceImpl implements RemoteGetGrupoDeRestricaoDatasource {
  final IClientService clientService;

  RemoteGetGrupoDeRestricaoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<RestricaoGrupoDeRestricaoEntity>> call(String search, {String? ultimoGrupoDeRestricaoId}) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'tipo'};

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (ultimoGrupoDeRestricaoId != null && ultimoGrupoDeRestricaoId.isNotEmpty) {
        queryParams['after'] = ultimoGrupoDeRestricaoId;
      }

      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/gruposderestricoes',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      return (response.data as List).map((e) => RestricaoGrupoDeRestricaoMapper.fromMapToGrupoDeRestricaoEntity(e)).toList();
    } on Failure {
      // TODO: Verificar essa falha
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRestricaoDatasourceImpl-getList'));
    }
  }
}
