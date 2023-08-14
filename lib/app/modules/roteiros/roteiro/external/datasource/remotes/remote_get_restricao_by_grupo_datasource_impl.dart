import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_restricao_by_grupo_datasource.dart';

class RemoteGetRestricaoByGrupoDatasourceImpl implements RemoteGetRestricaoByGrupoDatasource {
  final IClientService _clientService;

  RemoteGetRestricaoByGrupoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<RestricaoEntity>> call(String grupoDeRestricaoId) async {
    try {
      Map<String, dynamic> queryParams = {'grupo_de_restricao': grupoDeRestricaoId};

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.dadosmestre,
          endPoint: '/1234/restricoes',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      final data = List.from(response.data).map((map) => RemoteRestricaoMapper.fromMapToRestricao(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
