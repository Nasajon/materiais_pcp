import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/external/mappers/remote/grupo_de_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/datasources/remote/get_grupo_de_recurso_datasource.dart';

class GetGrupoDeRecursoDatasourceImpl implements GetGrupoDeRecursoDatasource {
  final IClientService clientService;

  GetGrupoDeRecursoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<RecursoGrupoDeRecurso>> getList({
    required String search,
    String? ultimoGrupoDeRecursoId,
  }) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'tipo'};

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (ultimoGrupoDeRecursoId != null && ultimoGrupoDeRecursoId.isNotEmpty) {
        queryParams['after'] = ultimoGrupoDeRecursoId;
      }

      final response = await clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/gruposderecursos',
        method: ClientRequestMethods.GET,
        queryParams: queryParams,
        interceptors: interceptors,
      ));

      return (response.data as List).map((e) => GrupoDeRecursoMapper.fromMapToGrupoDeRecurso(e)).toList();
    } on Failure {
      // TODO: Verificar essa falha
      rethrow;
    } on Exception catch (exception, stacktrace) {
      return Future.error(UnknownError(exception: exception, stackTrace: stacktrace, label: 'GrupoDeRecursoDatasourceImpl-getList'));
    }
  }
}
