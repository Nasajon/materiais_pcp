import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/external/datasources/remotes/remote_get_turno_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/infra/datasources/remotes/remote_get_turno_trabalho_datasource.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetTurnoTrabalhoDatasource remoteGetTurnoTrabalhoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetTurnoTrabalhoDatasource = RemoteGetTurnoTrabalhoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetTurnoTrabalhoDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos turnos de trabalho.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetTurnoTrabalhoDatasource();

          expect(response, isA<List<TurnoTrabalhoEntity>>());
          expect(response.length, 1);
        });
      });

      group('falha -', () {
        test('Deve retornar um CentroTrabalhoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetTurnoTrabalhoDatasource(), throwsA(isA<CentroTrabalhoFailure>()));
        });
      });
    });
  });
}

const jsonMock = <Map<String, dynamic>>[
  {
    'turno': '48883e31-aeb8-49b9-a5ff-bbdbc0ffcb14',
    'codigo': '1',
    'nome': 'TURNO 2',
    'horarios': [
      {
        'horario': 'd0d4f619-a39f-40fd-b41c-a9811683ad41',
        'inicio': '09:00:00',
        'fim': '18:00:00',
        'intervalo': '01:00:00',
        'domingo': false,
        'segunda': true,
        'terca': false,
        'quarta': true,
        'quinta': false,
        'sexta': true,
        'sabado': false
      },
      {
        'horario': 'f654f58f-0874-4d72-9147-674773604b34',
        'inicio': '09:00:00',
        'fim': '18:00:00',
        'intervalo': '01:00:00',
        'domingo': false,
        'segunda': false,
        'terca': true,
        'quarta': false,
        'quinta': true,
        'sexta': false,
        'sabado': true,
      },
    ],
  },
];
