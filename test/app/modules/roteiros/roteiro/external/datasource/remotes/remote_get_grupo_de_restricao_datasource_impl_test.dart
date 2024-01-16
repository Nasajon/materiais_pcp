import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_grupo_de_restricao_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/datasource/remotes/remote_get_grupo_de_restricao_datasource_impl.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetGrupoDeRestricaoDatasource remoteGetGrupoDeRestricaoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetGrupoDeRestricaoDatasource = RemoteGetGrupoDeRestricaoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetGrupoDeRestricaoDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos grupos de restrições quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetGrupoDeRestricaoDatasource('');

          expect(response, isA<List<GrupoDeRestricaoEntity>>());
          expect(response.length, 1);
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetGrupoDeRestricaoDatasource(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {
    'grupo_de_restricao': '101bcda9-bb22-409b-b05d-6d4e84e13899',
    'codigo': '1',
    'nome': 'Grupo 1',
    'tipo': 'componentes',
  }
];
