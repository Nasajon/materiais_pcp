import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_grupo_de_recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_grupo_de_recurso_datasource_impl.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetGrupoDeRecursoDatasource remoteGetGrupoDeRecursoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetGrupoDeRecursoDatasource = RemoteGetGrupoDeRecursoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetGrupoDeRecursoDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos grupos de recurso quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetGrupoDeRecursoDatasource('');

          expect(response, isA<List<GrupoDeRecursoEntity>>());
          expect(response.length, 1);
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetGrupoDeRecursoDatasource(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {
    'grupo_de_recurso': '97e14588-64cb-4594-96bf-dfe5d53cdaba',
    'codigo': '1',
    'nome': 'Teste 1',
    'tipo': 'equipamento',
  },
];
