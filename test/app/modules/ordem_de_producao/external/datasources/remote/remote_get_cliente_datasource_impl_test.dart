import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_get_cliente_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_cliente_datasource.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetClienteDatasource remoteGetClienteDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetClienteDatasource = RemoteGetClienteDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetClienteDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos clientes quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetClienteDatasource();

          expect(response, isA<List<ClienteEntity>>());
          expect(response.length, 2);
        });
      });

      group('falha -', () {
        test('Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetClienteDatasource(), throwsA(isA<OrdemDeProducaoFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {
    'id': '0683765b-847e-4a72-8109-f49bcd792518',
    'pessoa': '01',
    'nome': 'Maria',
  },
  {
    'id': '6353765b-847e-4a72-8109-f49bcd792518',
    'pessoa': '02',
    'nome': 'Pedro',
  },
];
