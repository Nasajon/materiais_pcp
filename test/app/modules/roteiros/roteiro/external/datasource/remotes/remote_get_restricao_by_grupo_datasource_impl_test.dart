import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_restricao_by_grupo_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_restricao_by_grupo_datasource.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetRestricaoByGrupoDatasource remoteGetRestricaoByGrupoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetRestricaoByGrupoDatasource = RemoteGetRestricaoByGrupoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetRestricaoByGrupoDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos restricões quando passar o id do grupo para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetRestricaoByGrupoDatasource('1');

          expect(response, isA<List<RestricaoEntity>>());
          expect(response.length, 3);
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetRestricaoByGrupoDatasource(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {
    'restricao': '7526cb27-31ec-42a0-8d32-df92a8d5bbaa',
    'codigo': '1',
    'nome': 'Restricao 1',
  },
  {
    'restricao': '1e4f3cc5-286d-4bcc-bda4-b0621a452087',
    'codigo': '2',
    'nome': 'Restricao 2',
  },
  {
    'restricao': '4c92a9a6-7961-4ccb-98c2-9e0ad35ce163',
    'codigo': '4',
    'nome': 'Restricao 4',
  }
];
