import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/errors/recurso_failures.dart';
import 'package:pcp_flutter/app/modules/recursos/external/mappers/remote/recurso_centro_de_trabalho_mapper.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/datasources/remote/remote_get_centro_de_trabalho_datasource.dart';

class GetCentroDeTrabalhoDatasourceImpl implements RemoteGetCentroDeTrabalhoDatasource {
  final IClientService clientService;

  GetCentroDeTrabalhoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<RecursoCentroDeTrabalho>> call({required String search, String? ultimoCentroDeTrabalhoId}) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (ultimoCentroDeTrabalhoId != null && ultimoCentroDeTrabalhoId.isNotEmpty) {
        queryParams['after'] = ultimoCentroDeTrabalhoId;
      }

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

      final data = List.from(response.data).map((map) => RecursoCentroDeTrabalhoMapper.fromMapToRecursoCentroDeTrabalho(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceRecursoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
