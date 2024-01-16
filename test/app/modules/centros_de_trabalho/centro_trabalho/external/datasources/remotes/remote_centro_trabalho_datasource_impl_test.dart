import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/external/datasources/remotes/remote_centro_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/infra/datasources/remotes/remote_centro_trabalho_datasource.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteCentroTrabalhoDatasource remoteCentroTrabalhoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteCentroTrabalhoDatasource = RemoteCentroTrabalhoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RoteiroRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('getCentroTrabalhoRecentes - Deve retornar uma lista de centro de trabalho recentes quando o a conexão for remota.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteCentroTrabalhoDatasource.getCentroTrabalhoRecentes();

          expect(response, isA<List<CentroTrabalhoAggregate>>());
        });

        test('getTodosCentroTrabalho - Deve retornar uma lista de centro de trabalho quando passar ou não uma pesquisa.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteCentroTrabalhoDatasource.getTodosCentroTrabalho('');

          expect(response, isA<List<CentroTrabalhoAggregate>>());
        });

        test('getCentroTrabalhoPorId - Deve retornar um CentroTrabalhoAggregate quando passar o id do centro de trabalho.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => ClientResponse(data: jsonMock[0], statusCode: 200),
          );

          final response = await remoteCentroTrabalhoDatasource.getCentroTrabalhoPorId('1');

          expect(response, isA<CentroTrabalhoAggregate>());
        });

        test('getTurnos - Deve retornar uma lista de TurnoTrabalhoEntity quando passar o id do turno.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonTurnoMock, statusCode: 200),
          );

          final response = await remoteCentroTrabalhoDatasource.getTurnos('', ['1']);

          expect(response, isA<List<TurnoTrabalhoEntity>>());
        });

        test(
            'inserirCentroTrabalho - Deve inserir o centro de trabalho e retornar o id quando passar os dados do centro de trabalho corretos.',
            () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => ClientResponse(data: jsonMock[0], statusCode: 200),
          );

          final response = await remoteCentroTrabalhoDatasource.inserirCentroTrabalho(CentroTrabalhoAggregate.empty());

          expect(response, isA<CentroTrabalhoAggregate>());
          expect(response.id, '8500df0f-73fa-4b57-9192-6b65402ad6ff');
        });

        test(
            'atualizarCentroTrabalho - Deve editar o centro de trabalho e retornar true quando passar os dados do centro de trabalho corretos.',
            () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => ClientResponse(data: jsonMock[0], statusCode: 200),
          );

          final response = await remoteCentroTrabalhoDatasource.atualizarCentroTrabalho(CentroTrabalhoAggregate.empty());

          expect(response, isA<bool>());
          expect(response, true);
        });

        test('deletarCentroTrabalho - Deve deletar o centro de trabalho e retornar true quando passar o id do centro de trabalho.',
            () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => ClientResponse(data: jsonMock[0], statusCode: 200),
          );

          final response = await remoteCentroTrabalhoDatasource.deletarCentroTrabalho('1');

          expect(response, isA<bool>());
          expect(response, true);
        });
      });

      group('falha -', () {
        test('getCentroTrabalhoRecentes - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteCentroTrabalhoDatasource.getCentroTrabalhoRecentes(), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('getTodosCentroTrabalho - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteCentroTrabalhoDatasource.getTodosCentroTrabalho(''), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('getCentroTrabalhoPorId - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteCentroTrabalhoDatasource.getCentroTrabalhoPorId(''), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('getTurnos - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteCentroTrabalhoDatasource.getTurnos('', ['1']), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('inserirCentroTrabalho - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteCentroTrabalhoDatasource.inserirCentroTrabalho(CentroTrabalhoAggregate.empty()),
              throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('atualizarCentroTrabalho - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteCentroTrabalhoDatasource.atualizarCentroTrabalho(CentroTrabalhoAggregate.empty()),
              throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('deletarCentroTrabalho - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteCentroTrabalhoDatasource.deletarCentroTrabalho('1'), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });
      });
    });
  });
}

const jsonMock = <Map<String, dynamic>>[
  {
    'centro_de_trabalho': '8500df0f-73fa-4b57-9192-6b65402ad6ff',
    'codigo': '1',
    'nome': 'centro de trabalho 07',
    'turnos': [
      {
        'turno_centro_de_trabalho': '7c0ea63e-7612-4df0-b29c-aa282ce4f7e8',
        'centro_de_trabalho': '8500df0f-73fa-4b57-9192-6b65402ad6ff',
        'turno': {
          'turno': '48883e31-aeb8-49b9-a5ff-bbdbc0ffcb14',
          'codigo': '1',
          'nome': 'TURNO 2',
        }
      }
    ]
  }
];

const jsonTurnoMock = <Map<String, dynamic>>[
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
