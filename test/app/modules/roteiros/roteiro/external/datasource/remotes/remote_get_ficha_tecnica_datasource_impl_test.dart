import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_ficha_tecnica_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_ficha_tecnica_datasource_impl.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetFichaTecnicaDatasource remoteGetFichaTecnicaDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetFichaTecnicaDatasource = RemoteGetFichaTecnicaDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetFichaTecnicaDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de fichas tecnica quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: <Map<String, dynamic>>[], statusCode: 200),
          );

          final response = await remoteGetFichaTecnicaDatasource('');

          expect(response, isA<List<FichaTecnicaEntity>>());
          expect(response.length, 0);
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetFichaTecnicaDatasource(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}
