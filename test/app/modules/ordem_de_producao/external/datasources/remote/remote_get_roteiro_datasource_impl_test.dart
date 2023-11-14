import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_get_roteiro_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_roteiro_datasource.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetRoteiroDatasource remoteGetRoteiroDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetRoteiroDatasource = RemoteGetRoteiroDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetRoteiroDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos roteiros quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetRoteiroDatasource('1');

          expect(response, isA<List<RoteiroEntity>>());
          expect(response.length, 1);
        });
      });

      group('falha -', () {
        test('Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetRoteiroDatasource('1'), throwsA(isA<OrdemDeProducaoFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {
    'roteiro': '8309142f-d493-4ce4-adce-7577306d5a58',
    'descricao': 'Roteiro',
    'codigo': '1',
    'unidade': {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2}
  }
];
