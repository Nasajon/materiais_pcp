import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_unidade_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_unidade_datasource.dart';

class RemoteGetUnidadeDatasourceImpl implements RemoteGetUnidadeDatasource {
  final IClientService _clientService;

  RemoteGetUnidadeDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<UnidadeEntity>> call(String search) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.dadosmestre,
          endPoint: '/4311/unidades',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      final data = List.from(response.data['result']).map((map) => RemoteUnidadeMapper.fromMapToUnidadeEntity(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
