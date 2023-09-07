import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_unidade_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_unidade_datasource.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetUnidadeDatasource remoteGetUnidadeDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetUnidadeDatasource = RemoteGetUnidadeDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetUnidadeDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos tipos de unidade quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetUnidadeDatasource('');

          expect(response, isA<List<UnidadeEntity>>());
          expect(response.length, 8);
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetUnidadeDatasource(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}

const jsonMock = [
  {'unidade': 'ec870668-fb64-495c-a7ac-abfeb64bd3c9', 'codigo': 'CM', 'nome': 'Centimetro', 'decimais': 2},
  {'unidade': 'e9bc4ce7-fa34-4d93-86f7-a9a34d4bf68e', 'codigo': 'GR', 'nome': 'Grama', 'decimais': 2},
  {'unidade': '482cb303-0a84-46a6-a8e6-5345fd655c70', 'codigo': 'KG', 'nome': 'Kilo', 'decimais': 2},
  {'unidade': 'edcb6c5b-8cd4-48e5-b098-98814835b2cd', 'codigo': 'KM', 'nome': 'Kilometro', 'decimais': 2},
  {'unidade': 'fca69f81-ddd6-47ff-ade7-c516488e90ad', 'codigo': 'LT', 'nome': 'Litro', 'decimais': 2},
  {'unidade': '2ad0f887-f9f5-469f-83f4-6f7acf4de211', 'codigo': 'ML', 'nome': 'Mililitro', 'decimais': 2},
  {'unidade': '8ae427ed-c32b-4bb8-b0cd-1cfed48c309b', 'codigo': 'T', 'nome': 'Tonelada', 'decimais': 2},
  {'unidade': '45448dce-c4c1-4106-84fb-4c41fe476d8a', 'codigo': 'UN', 'nome': 'Unidade', 'decimais': 0}
];
