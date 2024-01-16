import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/errors/recurso_failures.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/turno_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/restricao/external/mapper/remote/remote_turno_de_trabalho_mapper.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/datasources/remote/remote_get_turno_de_trabalho_datasource.dart';

class RemoteGetTurnoDeTrabalhoDatasourceImpl implements RemoteGetTurnoDeTrabalhoDatasource {
  final IClientService _clientService;

  RemoteGetTurnoDeTrabalhoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<TurnoDeTrabalhoEntity>> call(String centroDeTrabalhoId, {required String search, String? ultimoTurnoTrabalhoId}) async {
    try {
      Map<String, dynamic> queryParams = {};
      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (ultimoTurnoTrabalhoId != null && ultimoTurnoTrabalhoId.isNotEmpty) {
        queryParams['after'] = ultimoTurnoTrabalhoId;
      }

      final response = await _clientService.request(ClientRequestParams(
        selectedApi: APIEnum.pcp,
        endPoint: '/turnos/centrodetrabalho/$centroDeTrabalhoId',
        method: ClientRequestMethods.GET,
        interceptors: interceptors,
      ));

      return List.from(response.data).map((map) => RemoteTurnoDeTrabalhoMapper.fromMapToTurnoTrabalho(map)).toList();
    } on ClientError catch (e) {
      throw DatasourceRecursoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
