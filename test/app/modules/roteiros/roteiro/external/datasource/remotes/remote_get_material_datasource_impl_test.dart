import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_material_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_material_datasource.dart';

class ClientServiceErrorMock extends Mock implements IClientService {}

class ClientServiceMock extends Mock implements IClientService {
  @override
  Future<ClientResponse> request(ClientRequestParams params) async {
    if (params.endPoint == '/1234/fichastecnicas?fields=produtos,unidades') {
      return const ClientResponse(data: jsonMock, statusCode: 200);
    } else if (params.endPoint == '/4311/produtos?id=358c2657-00e1-48dc-8beb-5175d691bc30') {
      return const ClientResponse(data: jsonProdutoMock, statusCode: 200);
    } else if (params.endPoint == '/4311/unidades?id=fbf7ab8a-11d5-4170-99c6-ade99311b4ed') {
      return const ClientResponse(data: jsonUnidadeMock, statusCode: 200);
    }
    throw ClientError(message: 'error', statusCode: 500);
  }
}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetMaterialDatasource remoteGetMaterialDatasource;

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  group('RemoteGetMaterialDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        setUp(() {
          clientService = ClientServiceMock();
          remoteGetMaterialDatasource = RemoteGetMaterialDatasourceImpl(clientService);
          registerFallbackValue(ClientRequestParamsMock());
        });

        test('Deve retornar uma lista dos Materiais quando informar o codigo da ficha tecnica ao backend.', () async {
          final response = await remoteGetMaterialDatasource('');

          expect(response, isA<List<MaterialEntity>>());
          expect(response.length, 1);
        });
      });

      group('falha -', () {
        setUp(() {
          clientService = ClientServiceErrorMock();
          remoteGetMaterialDatasource = RemoteGetMaterialDatasourceImpl(clientService);
          registerFallbackValue(ClientRequestParamsMock());
        });

        test('Deve retornar um RoteiroFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetMaterialDatasource(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {
    'ficha_tecnica_produto': '97e14588-64cb-4594-96bf-dfe5d53cdaba',
    'produto': '358c2657-00e1-48dc-8beb-5175d691bc30',
    'unidade': 'fbf7ab8a-11d5-4170-99c6-ade99311b4ed',
    'quantidade': 3.0,
  },
];

const jsonUnidadeMock = <String, dynamic>{
  'next': null,
  'prev': null,
  'result': [
    {
      'id': 'fbf7ab8a-11d5-4170-99c6-ade99311b4ed',
      'codigo': 'UN',
      'descricao': 'UNIDADE',
    }
  ]
};

const jsonProdutoMock = <String, dynamic>{
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
