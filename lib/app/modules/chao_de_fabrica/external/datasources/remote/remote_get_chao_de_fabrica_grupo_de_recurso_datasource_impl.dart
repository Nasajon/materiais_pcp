import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_grupo_de_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_get_chao_de_fabrica_grupo_de_recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_get_chao_de_fabrica_recurso_datasource.dart';

class RemoteGetChaoDeFabricaGrupoDeRecursoDatasourceImpl implements RemoteGetChaoDeFabricaGrupoDeRecursoDatasource {
  final IClientService _clientService;

  RemoteGetChaoDeFabricaGrupoDeRecursoDatasourceImpl({required IClientService clientService}) : _clientService = clientService;

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<ChaoDeFabricaGrupoDeRecursoEntity>> call({String? ultimoGrupoDeRecursoId}) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (ultimoGrupoDeRecursoId != null && ultimoGrupoDeRecursoId.isNotEmpty) {
        queryParams['after'] = ultimoGrupoDeRecursoId;
      }

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/gruposderecursos',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
          body: <String, dynamic>{},
        ),
      );

      final data = List.from(response.data).map((map) {
        return RemoteChaoDeFabricaGrupoDeRecursoMapper.fromMapToGrupoDeRecurso(map);
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
