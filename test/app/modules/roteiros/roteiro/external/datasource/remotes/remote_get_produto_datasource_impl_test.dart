import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_produto_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_produto_datasource.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetProdutoDatasource remoteGetProdutoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetProdutoDatasource = RemoteGetProdutoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetProdutoDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos produtos quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetProdutoDatasource('');

          expect(response, isA<List<ProdutoEntity>>());
          expect(response.length, 1);
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetProdutoDatasource(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}

const jsonMock = {
  'next': null,
  'prev': null,
  'result': [
    {
      'id': '358c2657-00e1-48dc-8beb-5175d691bc30',
      'codigo': '003',
      'especificacao': 'Doritos Queijo Nacho',
      'unidade_padrao': 'fbf7ab8a-11d5-4170-99c6-ade99311b4ed',
      'ncm': '19059090'
    }
  ]
};
