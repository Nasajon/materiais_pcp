import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_grupo_de_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_grupo_de_restricao_datasource.dart';

class RemoteGetGrupoDeRestricaoDatasourceImpl implements RemoteGetGrupoDeRestricaoDatasource {
  final IClientService _clientService;

  RemoteGetGrupoDeRestricaoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<GrupoDeRestricaoEntity>> call(String search) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/1234/gruposderestricoes',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      final data = List.from(response.data).map((map) => RemoteGrupoDeRestricaoMapper.fromMapToGrupoDeRestricao(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
