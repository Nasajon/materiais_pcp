import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_centro_de_trabalho_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_get_chao_de_fabrica_centro_de_trabalho_datasource.dart';

class RemoteGetChaoDeFabricaCentroDeTrabalhoDatasourceImpl implements RemoteGetChaoDeFabricaCentroDeTrabalhoDatasource {
  final IClientService _clientService;

  RemoteGetChaoDeFabricaCentroDeTrabalhoDatasourceImpl({required IClientService clientService}) : _clientService = clientService;

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<ChaoDeFabricaCentroDeTrabalhoEntity>> call({required String search, String? ultimoCentroDeTrabalhoId}) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (ultimoCentroDeTrabalhoId != null && ultimoCentroDeTrabalhoId.isNotEmpty) {
        queryParams['after'] = ultimoCentroDeTrabalhoId;
      }

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/centrosdetrabalhos',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
          body: <String, dynamic>{},
        ),
      );

      final data = List.from(response.data).map((map) {
        return RemoteChaoDeFabricaCentroDeTrabalhoMapper.fromMapToCentroDeTrabalho(map);
      }).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceChaoDeFabricaFailure(
        errorMessage: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }
}
