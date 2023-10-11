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
          expect(response.length, 10);
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

const jsonMock = [
  {
    'produto': '0683765b-847e-4a72-8109-f49bcd792518',
    'codigo': '01',
    'nome': 'Bolo',
    'unidade_padrao': {
      'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70',
      'codigo': 'KG',
      'nome': 'Kilo',
      'decimais': 2,
    },
  },
  {
    'produto': '21d0d1fb-40f1-4c91-9581-7a40644bad9b',
    'codigo': '02',
    'nome': 'Ovo',
    'unidade_padrao': {
      'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70',
      'codigo': 'KG',
      'nome': 'Kilo',
      'decimais': 2,
    },
  },
  {
    'produto': 'e6aafbcd-2ab7-4c2d-a2c6-0a2899318382',
    'codigo': '03',
    'nome': 'Leite',
    'unidade_padrao': {
      'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70',
      'codigo': 'KG',
      'nome': 'Kilo',
      'decimais': 2,
    },
  },
  {
    'produto': 'a2579099-1caf-4ba9-ba99-c8747c162dc9',
    'codigo': '04',
    'nome': 'Manteiga',
    'unidade_padrao': {
      'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70',
      'codigo': 'KG',
      'nome': 'Kilo',
      'decimais': 2,
    },
  },
  {
    'produto': '59331cb7-cd94-4ff6-ae12-d69db0265802',
    'codigo': '05',
    'nome': 'Açúcar',
    'unidade_padrao': {
      'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70',
      'codigo': 'KG',
      'nome': 'Kilo',
      'decimais': 2,
    },
  },
  {
    'produto': 'a33bd64d-d9a6-4134-86ab-049e69d099f6',
    'codigo': '06',
    'nome': 'Farinha',
    'unidade_padrao': {
      'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70',
      'codigo': 'KG',
      'nome': 'Kilo',
      'decimais': 2,
    },
  },
  {
    'produto': '484aef35-8560-41cc-b70f-a585cdae3b69',
    'codigo': '07',
    'nome': 'Óleo',
    'unidade_padrao': {
      'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70',
      'codigo': 'KG',
      'nome': 'Kilo',
      'decimais': 2,
    },
  },
  {
    'produto': '6b10e6e1-802d-4c02-9ed6-692907fb33a8',
    'codigo': '08',
    'nome': 'Fermento',
    'unidade_padrao': {
      'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70',
      'codigo': 'KG',
      'nome': 'Kilo',
      'decimais': 2,
    },
  },
  {
    'produto': '2231e1ed-e27e-41e9-9354-2a713bbe926c',
    'codigo': '09',
    'nome': 'Recheio Chocolate',
    'unidade_padrao': {
      'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70',
      'codigo': 'KG',
      'nome': 'Kilo',
      'decimais': 2,
    },
  },
  {
    'produto': 'c981653c-cea5-4bdc-819c-ba1774600037',
    'codigo': '10',
    'nome': 'Massa',
    'unidade_padrao': {
      'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70',
      'codigo': 'KG',
      'nome': 'Kilo',
      'decimais': 2,
    },
  }
];
