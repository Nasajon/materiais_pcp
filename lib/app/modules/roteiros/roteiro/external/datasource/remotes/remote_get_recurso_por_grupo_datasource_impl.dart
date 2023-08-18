import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_recurso_por_grupo_datasource.dart';

class RemoteGetRecursoPorGrupoDatasourceImpl implements RemoteGetRecursoPorGrupoDatasource {
  final IClientService _clientService;

  RemoteGetRecursoPorGrupoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<RecursoAggregate>> call(String idGrupoDeRecurso) async {
    try {
      Map<String, dynamic> queryParams = {'grupo_de_recurso': idGrupoDeRecurso};

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.dadosmestre,
          endPoint: '/1234/recursos',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      final data = List.from(response.data).map((map) => RemoteRecursoMapper.fromMapToRecurso(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw RemoteDatasourceRoteiroFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
