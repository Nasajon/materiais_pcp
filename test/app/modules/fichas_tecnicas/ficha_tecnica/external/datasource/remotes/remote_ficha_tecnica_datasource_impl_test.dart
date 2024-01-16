import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/datasources/remotes/remote_ficha_tecnica_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/datasources/remotes/remote_ficha_tecnica_datasource.dart';

import '../../../domain/entities/inserir_atualizar_ficha_tecnica.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteFichaTecnicaDatasource remoteFichaTecnicaDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteFichaTecnicaDatasource = RemoteFichaTecnicaDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteFichaTecnicaDatasource -', () {
    group('getTodosFichaTecnica -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de fichas técnicas quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonGetListMock, statusCode: 200),
          );

          final response = await remoteFichaTecnicaDatasource.getTodosFichaTecnica('');

          expect(response, isA<List<FichaTecnicaAggregate>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um FichaTecnicaFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteFichaTecnicaDatasource.getTodosFichaTecnica(''), throwsA(isA<FichaTecnicaFailure>()));
        });
      });
    });
    group('getTodosProdutosPorIds -', () {
      group('sucesso -', () {
        test('Deve retornar uma ficha tecnica quando informar um id.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonGetMock, statusCode: 200),
          );

          final response = await remoteFichaTecnicaDatasource.getFichaTecnicaPorId("21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6");

          expect(response, isA<FichaTecnicaAggregate>());
        });
      });

      group('falha -', () {
        test('Deve retornar um FichaTecnicaFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteFichaTecnicaDatasource.getFichaTecnicaPorId("21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6"),
              throwsA(isA<FichaTecnicaFailure>()));
        });
      });
    });
    group('deletarFichaTecnica -', () {
      group('sucesso -', () {
        test('Deve retornar uma ficha tecnica quando informar um id.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonGetMock, statusCode: 200),
          );

          final response = await remoteFichaTecnicaDatasource.deletarFichaTecnica("21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6");

          expect(response, isA<bool>());
          expect(response, true);
        });
      });

      group('falha -', () {
        test('Deve retornar um FichaTecnicaFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteFichaTecnicaDatasource.getFichaTecnicaPorId("21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6"),
              throwsA(isA<FichaTecnicaFailure>()));
        });
      });
    });
    group('getFichaTecnicaRecentes -', () {
      group('sucesso -', () {
        test('Deve retornar uma ficha tecnica quando informar um id.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonGetListMock, statusCode: 200),
          );

          final response = await remoteFichaTecnicaDatasource.getFichaTecnicaRecentes();

          expect(response, isA<List<FichaTecnicaAggregate>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um FichaTecnicaFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteFichaTecnicaDatasource.getFichaTecnicaRecentes(), throwsA(isA<FichaTecnicaFailure>()));
        });
      });
    });
    group('atualizarFichaTecnica -', () {
      group('sucesso -', () {
        test('Deve retornar um boolean quando informar uma ficha tecnica valida para atualizar.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonGetMock, statusCode: 200),
          );

          final response = await remoteFichaTecnicaDatasource.atualizarFichaTecnica(fichaTecnicaAtualizar);

          expect(response, isA<bool>());
          expect(response, true);
        });
      });

      group('falha -', () {
        test('Deve retornar um FichaTecnicaFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteFichaTecnicaDatasource.atualizarFichaTecnica(fichaTecnicaAtualizar), throwsA(isA<FichaTecnicaFailure>()));
        });
      });
    });

    group('inserirFichaTecnica -', () {
      group('sucesso -', () {
        test('Deve retornar um boolean quando informar uma ficha tecnica valida para atualizar.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonGetMock, statusCode: 200),
          );

          final response = await remoteFichaTecnicaDatasource.inserirFichaTecnica(fichaTecnicaCriar);

          expect(response, isA<FichaTecnicaAggregate>());
          expect(response.id, jsonGetMock['ficha_tecnica']);
        });
      });

      group('falha -', () {
        test('Deve retornar um FichaTecnicaFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteFichaTecnicaDatasource.inserirFichaTecnica(fichaTecnicaAtualizar), throwsA(isA<FichaTecnicaFailure>()));
        });
      });
    });
  });
}

const jsonGetListMock = [
  {
    "ficha_tecnica": "21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6",
    "codigo": "01",
    "descricao": "teste",
    "quantidade": 1.0,
    "produto": {"produto": "0683765b-847e-4a72-8109-f49bcd792518", "codigo": "01", "nome": "Bolo"},
    "unidade": {"unidade": "fca69f81-ddd6-47ff-ade7-c516488e90ad", "codigo": "LT", "nome": "Litro", "decimais": 2}
  }
];

const jsonGetMock = {
  "ficha_tecnica": "21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6",
  "codigo": "01",
  "descricao": "teste",
  "quantidade": 1.0,
  "produto": {"produto": "0683765b-847e-4a72-8109-f49bcd792518", "codigo": "01", "nome": "Bolo"},
  "unidade": {"unidade": "fca69f81-ddd6-47ff-ade7-c516488e90ad", "codigo": "LT", "nome": "Litro", "decimais": 2}
};
