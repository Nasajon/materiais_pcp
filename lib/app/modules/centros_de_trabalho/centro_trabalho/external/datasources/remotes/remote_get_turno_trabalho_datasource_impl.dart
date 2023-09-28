import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/external/mappers/remotes/remote_turno_trabanho_mappers.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/infra/datasources/remotes/remote_get_turno_trabalho_datasource.dart';

class RemoteGetTurnoTrabalhoDatasourceImpl implements RemoteGetTurnoTrabalhoDatasource {
  final IClientService _clientService;

  RemoteGetTurnoTrabalhoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<TurnoTrabalhoEntity>> call() async {
    try {
      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/turnos',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          body: <String, dynamic>{},
        ),
      );

      final data = List.from(response.data).map((map) => RemoteTurnoTrabalhoMapper.fromMapToTurnoTrabalhoEntity(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceCentroTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }
}
