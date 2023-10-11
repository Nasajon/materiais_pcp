import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/datasources/remotes/remote_unidade_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_unidade_datasource.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteUnidadeDatasource remoteUnidadeDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteUnidadeDatasource = RemoteUnidadeDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteUnidadeDatasourceImpl -', () {
    group('getTodasUnidades -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de unidades quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteUnidadeDatasource.getTodasUnidades('');

          expect(response, isA<List<UnidadeEntity>>());
          expect(response.length, 2);
        });
      });

      group('falha -', () {
        test('Deve retornar um FichaTecnicaFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteUnidadeDatasource.getTodasUnidades(''), throwsA(isA<FichaTecnicaFailure>()));
        });
      });
    });
    group('getTodasUnidadesPorIds -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de unidades quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteUnidadeDatasource.getTodasUnidadesPorIds(['']);

          expect(response, isA<Map<String, UnidadeEntity>>());
          expect(response.length, 2);
        });
      });

      group('falha -', () {
        test('Deve retornar um FichaTecnicaFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteUnidadeDatasource.getTodasUnidadesPorIds(['']), throwsA(isA<FichaTecnicaFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {"unidade": "ec870668-fb64-495c-a7ac-abfeb64bd3c9", "codigo": "CM", "nome": "Centimetro", "decimais": 2},
  {"unidade": "e9bc4ce7-fa34-4d93-86f7-a9a34d4bf68e", "codigo": "GR", "nome": "Grama", "decimais": 2},
];
