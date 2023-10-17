import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/external/datasources/remote/remote_turno_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/infra/datasources/remote/remote_turno_trabalho_datasource.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteTurnoTrabalhoDatasource remoteTurnoTrabalhoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteTurnoTrabalhoDatasource = RemoteTurnoTrabalhoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RoteiroRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('getTurnoTrabalhoRecentes - Deve retornar uma lista de turno de trabalho recentes quando o a conexão for remota.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteTurnoTrabalhoDatasource.getTurnoTrabalhoRecentes();

          expect(response, isA<List<TurnoTrabalhoAggregate>>());
        });

        test('getTurnosTrabalhos - Deve retornar uma lista de turno de trabalho recentes quando passar ou não uma pesquisa.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteTurnoTrabalhoDatasource.getTurnosTrabalhos(search: '');

          expect(response, isA<List<TurnoTrabalhoAggregate>>());
        });

        test('getTurnoTrabalhoPorId - Deve retornar um TurnoTrabalhoAggregate quando passar o id do turno de trabalho.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => ClientResponse(data: jsonMock[0], statusCode: 200),
          );

          final response = await remoteTurnoTrabalhoDatasource.getTurnoTrabalhoPorId('1');

          expect(response, isA<TurnoTrabalhoAggregate>());
        });

        test('inserir - Deve inserir o turno de trabalho e retornar o id quando passar os dados do turno de trabalho corretos.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => ClientResponse(data: jsonMock[0], statusCode: 200),
          );

          final response = await remoteTurnoTrabalhoDatasource.inserir(TurnoTrabalhoAggregate.empty());

          expect(response, isA<TurnoTrabalhoAggregate>());
          expect(response.id, '48883e31-aeb8-49b9-a5ff-bbdbc0ffcb14');
        });

        test('editar - Deve editar o turno de trabalho e retornar true quando passar os dados do turno de trabalho corretos.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => ClientResponse(data: jsonMock[0], statusCode: 200),
          );

          final response = await remoteTurnoTrabalhoDatasource.editar(TurnoTrabalhoAggregate.empty());

          expect(response, isA<bool>());
          expect(response, true);
        });

        test('deletar - Deve deletar o turno de trabalho e retornar true quando passar o id do turno de trabalho.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => ClientResponse(data: jsonMock[0], statusCode: 200),
          );

          final response = await remoteTurnoTrabalhoDatasource.deletar('1');

          expect(response, isA<bool>());
          expect(response, true);
        });
      });

      group('falha -', () {
        test('getTurnoTrabalhoRecentes - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteTurnoTrabalhoDatasource.getTurnoTrabalhoRecentes(), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });

        test('getTurnosTrabalhos - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteTurnoTrabalhoDatasource.getTurnosTrabalhos(search: ''), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });

        test('getTurnoTrabalhoPorId - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteTurnoTrabalhoDatasource.getTurnoTrabalhoPorId(''), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });

        test('inserir - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(
              () => remoteTurnoTrabalhoDatasource.inserir(TurnoTrabalhoAggregate.empty()), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });

        test('editar - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(
              () => remoteTurnoTrabalhoDatasource.editar(TurnoTrabalhoAggregate.empty()), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });

        test('deletar - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => clientService.request(any())).thenThrow(ClientError(message: '', statusCode: 500));

          expect(() => remoteTurnoTrabalhoDatasource.deletar('1'), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
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
