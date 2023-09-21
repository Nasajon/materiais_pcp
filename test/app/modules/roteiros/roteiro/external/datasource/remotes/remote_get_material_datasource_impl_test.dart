import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_material_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_material_datasource.dart';

class ClientServiceErrorMock extends Mock implements IClientService {}

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetMaterialDatasource remoteGetMaterialDatasource;

  group('RemoteGetMaterialDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        setUp(() {
          clientService = ClientServiceMock();
          remoteGetMaterialDatasource = RemoteGetMaterialDatasourceImpl(clientService);
          registerFallbackValue(ClientRequestParamsMock());
        });

        test('Deve retornar uma lista dos Materiais quando informar o codigo da ficha tecnica ao backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

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

const jsonMock = {
  'ficha_tecnica': '21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6',
  'codigo': '01',
  'descricao': 'teste',
  'quantidade': 1.0,
  'produtos': [
    {
      'ficha_tecnica_produto': 'aace47ba-c40e-49ae-9fa5-ccef6d5e0f6f',
      'quantidade': 10.0,
      'ficha_tecnica': '21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6',
      'produto': {
        'produto': 'e6aafbcd-2ab7-4c2d-a2c6-0a2899318382',
        'codigo': '03',
        'nome': 'Leite',
        'unidade_padrao': '482cb303-0a84-46a6-a8e6-5345fd655c70'
      },
      'unidade': {
        'unidade': 'fca69f81-ddd6-47ff-ade7-c516488e90ad',
        'codigo': 'LT',
        'nome': 'Litro',
        'decimais': 2,
      }
    }
  ]
};
