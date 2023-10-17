import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/external/mappers/remote/remote_horario_mapper.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/external/mappers/remote/remote_turno_trabalho_mapper.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/infra/datasources/remote/remote_turno_trabalho_datasource.dart';

class RemoteTurnoTrabalhoDatasourceImpl implements RemoteTurnoTrabalhoDatasource {
  final IClientService clientService;

  RemoteTurnoTrabalhoDatasourceImpl(this.clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<TurnoTrabalhoAggregate>> getTurnoTrabalhoRecentes() async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/turnos',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          body: <String, dynamic>{},
        ),
      );

      final data = List.from(response.data).map((map) => RemoteTurnoTrabalhoMapper.fromMapToTurnoTrabalho(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceTurnoTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<List<TurnoTrabalhoAggregate>> getTurnosTrabalhos({required String search}) async {
    Map<String, dynamic> queryParams = {};

    if (search.isNotEmpty) {
      queryParams['search'] = search;
    }

    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/turnos',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
          body: <String, dynamic>{},
        ),
      );

      final data = List.from(response.data).map((map) => RemoteTurnoTrabalhoMapper.fromMapToTurnoTrabalho(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceTurnoTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<TurnoTrabalhoAggregate> getTurnoTrabalhoPorId(String id) async {
    try {
      Map<String, dynamic> queryParams = {'fields': 'horarios'};

      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/turnos/$id',
          method: ClientRequestMethods.GET,
          queryParams: queryParams,
          interceptors: interceptors,
          body: <String, dynamic>{},
        ),
      );
      var turno = RemoteTurnoTrabalhoMapper.fromMapToTurnoTrabalho(response.data);

      return turno.copyWith(horarios: RemoteHorarioMapper.setarIndexParaOsHorarios(turno.horarios));
    } on ClientError catch (e) {
      throw DatasourceTurnoTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<TurnoTrabalhoAggregate> inserir(TurnoTrabalhoAggregate turno) async {
    try {
      final response = await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/turnos',
          method: ClientRequestMethods.POST,
          interceptors: interceptors,
          body: RemoteTurnoTrabalhoMapper.fromTurnoTrabalhoToMap(turno),
        ),
      );

      turno = turno.copyWith(id: response.data['turno']);

      return turno;
    } on ClientError catch (e) {
      throw DatasourceTurnoTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<bool> editar(TurnoTrabalhoAggregate turno) async {
    try {
      await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/turnos/${turno.id}',
          method: ClientRequestMethods.PUT,
          interceptors: interceptors,
          body: RemoteTurnoTrabalhoMapper.fromTurnoTrabalhoToMap(turno),
        ),
      );

      return true;
    } on ClientError catch (e) {
      throw DatasourceTurnoTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }

  @override
  Future<bool> deletar(String id) async {
    try {
      await clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/turnos/$id',
          method: ClientRequestMethods.DELETE,
          interceptors: interceptors,
        ),
      );

      return true;
    } on ClientError catch (e) {
      throw DatasourceTurnoTrabalhoFailure(errorMessage: e.message, stackTrace: e.stackTrace, exception: e.exception);
    }
  }
}

final json = [
  {
    'id': '123',
    'codigo': '123',
    'nome': 'Teste 1',
    'horarios': [],
  }
];
