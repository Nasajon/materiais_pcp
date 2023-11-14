import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/datasources/remotes/remote_produto_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_produto_datasource%20copy.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteProdutoDatasource remoteProdutoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteProdutoDatasource = RemoteProdutoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteProdutoDatasourceImpl -', () {
    group('getTodosProdutos -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de produtos quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteProdutoDatasource.getTodosProdutos('');

          expect(response, isA<List<ProdutoEntity>>());
          expect(response.length, 2);
        });
      });

      group('falha -', () {
        test('Deve retornar um FichaTecnicaFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteProdutoDatasource.getTodosProdutos(''), throwsA(isA<FichaTecnicaFailure>()));
        });
      });
    });
    group('getTodosProdutosPorIds -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de produtos quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteProdutoDatasource.getTodosProdutosPorIds(['']);

          expect(response, isA<Map<String, ProdutoEntity>>());
          expect(response.length, 2);
        });
      });

      group('falha -', () {
        test('Deve retornar um FichaTecnicaFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteProdutoDatasource.getTodosProdutosPorIds(['']), throwsA(isA<FichaTecnicaFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {
    "produto": "0683765b-847e-4a72-8109-f49bcd792518",
    "codigo": "01",
    "nome": "Bolo",
    "unidade_padrao": {"unidade": "482cb303-0a84-46a6-a8e6-5345fd655c70", "codigo": "KG", "nome": "Kilo", "decimais": 2}
  },
  {
    "produto": "21d0d1fb-40f1-4c91-9581-7a40644bad9b",
    "codigo": "02",
    "nome": "Ovo",
    "unidade_padrao": {"unidade": "482cb303-0a84-46a6-a8e6-5345fd655c70", "codigo": "KG", "nome": "Kilo", "decimais": 2}
  }
];
