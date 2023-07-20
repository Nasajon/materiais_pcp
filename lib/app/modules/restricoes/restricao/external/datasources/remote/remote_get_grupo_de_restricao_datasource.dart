import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/external/mapper/remote/grupo_de_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/infra/datasources/remote/remote_get_grupo_de_restricao_datasource.dart';

class RemoteGetGrupoDeRestricaoDatasourceImpl implements RemoteGetGrupoDeRestricaoDatasource {
  final IClientService clientService;

  RemoteGetGrupoDeRestricaoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<GrupoDeRestricaoEntity>> call() async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'tipo'};

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
}
