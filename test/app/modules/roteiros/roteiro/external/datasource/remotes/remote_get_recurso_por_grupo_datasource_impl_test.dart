import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_recurso_por_grupo_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_recurso_por_grupo_datasource_impl.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetRecursoPorGrupoDatasource remoteGetRecursoPorGrupoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetRecursoPorGrupoDatasource = RemoteGetRecursoPorGrupoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetRecursoPorGrupoDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos recursos quando passar o id do grupo para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetRecursoPorGrupoDatasource('1');

          expect(response, isA<List<RecursoAggregate>>());
          expect(response.length, 1);
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetRecursoPorGrupoDatasource(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {
    'recurso': '0758c570-932a-4345-9fe8-323ebe38f207',
    'codigo': '2',
    'nome': 'Recurso 2',
  },
];
