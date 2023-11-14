import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_centro_de_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_centro_de_trabalho_datasource_impl.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetCentroDeTrabalhoDatasource remoteGetCentroDeTrabalhoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetCentroDeTrabalhoDatasource = RemoteGetCentroDeTrabalhoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetCentroDeTrabalhoDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de centro de trabalho quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetCentroDeTrabalhoDatasource('');

          expect(response, isA<List<CentroDeTrabalhoEntity>>());
          expect(response.length, 2);
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetCentroDeTrabalhoDatasource(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {
    'centro_de_trabalho': '74dcd3fa-036d-4b62-b757-fe4888d354ed',
    'codigo': '1',
    'nome': 'Centro 1',
  },
  {
    'centro_de_trabalho': '74dcd3fa-036d-4b62-b757-fe4888d354cd',
    'codigo': '2',
    'nome': 'Centro 2',
  }
];
