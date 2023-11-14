import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_get_operacao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_operacao_datasource.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteGetOperacaoDatasource remoteGetOperacaoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteGetOperacaoDatasource = RemoteGetOperacaoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteGetOperacaoDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista das operações do roteiro quando informar ou id do roteiro para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: jsonMock, statusCode: 200),
          );

          final response = await remoteGetOperacaoDatasource('1');

          expect(response, isA<List<OperacaoAggregate>>());
          expect(response.length, 2);
        });
      });

      group('falha -', () {
        test('Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetOperacaoDatasource(''), throwsA(isA<OrdemDeProducaoFailure>()));
        });
      });
    });
  });
}

const jsonMock = {
  'roteiro': '8309142f-d493-4ce4-adce-7577306d5a58',
  'descricao': 'Roteiro',
  'codigo': '1',
  'operacoes': [
    {
      'operacao': '0910c523-0ea4-4f0a-8b6f-d7d33f52c859',
      'codigo': '10',
      'nome': 'Operação 1',
      'roteiro': '8309142f-d493-4ce4-adce-7577306d5a58',
      'ordem': 1,
      'razao_conversao': 1.0,
      'medicao_tempo': 'por_lote',
      'preparacao': '00:00:00',
      'execucao': '00:10:00',
      'grupos_recursos': [
        {
          'grupo_recurso_operacao': 'b7c023fd-4c97-45da-b85c-f6ecf3042d8a',
          'tempo_de_preparacao': '00:00:00',
          'tempo_de_processamento': '00:12:00',
          'quantidade_minima': 0.01,
          'quantidade_maxima': 0.01,
          'quantidade_total': 0.01,
          'recursos': [
            {
              'recurso_operacao': 'e304d09c-8b17-4aaa-b977-0b3b2a2989c9',
              'tempo_de_preparacao': '00:00:00',
              'tempo_de_processamento': '00:12:00',
              'quantidade_minima': 0.01,
              'quantidade_maxima': 0.01,
              'quantidade_total': 0.01,
              'grupo_recurso_operacao': 'b7c023fd-4c97-45da-b85c-f6ecf3042d8a',
              'recurso': {
                'recurso': 'b68eedab-4cc2-47d5-8390-85518a34f3bd',
                'codigo': '05',
                'nome': 'teste 5',
              },
            }
          ],
          'grupo_de_recurso': {
            'grupo_de_recurso': '15259eed-653f-4c1a-b0e6-a095332b182a',
            'codigo': '01',
            'nome': 'grupo 01',
            'tipo': 'mao_de_obra'
          }
        }
      ],
      'produtos': [
        {
          'produto_operacao': 'e60b565c-d460-4a55-b155-fd17085cea2a',
          'operacao': '0910c523-0ea4-4f0a-8b6f-d7d33f52c859',
          'quantidade': 5.0,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': 'aace47ba-c40e-49ae-9fa5-ccef6d5e0f6f',
          'unidade': {
            'unidade': 'fca69f81-ddd6-47ff-ade7-c516488e90ad',
            'codigo': 'LT',
            'nome': 'Litro',
            'decimais': 2,
          },
          'produto': {
            'produto': 'e6aafbcd-2ab7-4c2d-a2c6-0a2899318382',
            'codigo': '03',
            'nome': 'Leite',
          },
        }
      ],
      'centro_de_trabalho': {
        'centro_de_trabalho': '8500df0f-73fa-4b57-9192-6b65402ad6ff',
        'codigo': '1',
        'nome': 'centro de trabalho 07',
      },
    },
    {
      'operacao': 'ba7e0d9a-493a-49a8-8a62-fb5938138fe2',
      'codigo': '20',
      'nome': 'Operação 2',
      'roteiro': '8309142f-d493-4ce4-adce-7577306d5a58',
      'ordem': 2,
      'razao_conversao': 1.0,
      'medicao_tempo': 'tempo_fixo',
      'preparacao': '00:00:00',
      'execucao': '00:03:00',
      'grupos_recursos': [
        {
          'grupo_recurso_operacao': '1327060c-8237-490f-baf4-24d7ad8804ca',
          'tempo_de_preparacao': '00:00:00',
          'tempo_de_processamento': '00:04:00',
          'quantidade_minima': 0.01,
          'quantidade_maxima': 0.01,
          'quantidade_total': 0.01,
          'recursos': [
            {
              'recurso_operacao': 'bec8ea08-334e-4b07-9e17-a526f1c1e930',
              'tempo_de_preparacao': '00:00:00',
              'tempo_de_processamento': '00:04:00',
              'quantidade_minima': 0.01,
              'quantidade_maxima': 0.01,
              'quantidade_total': 0.01,
              'grupo_recurso_operacao': '1327060c-8237-490f-baf4-24d7ad8804ca',
              'recurso': {
                'recurso': 'b68eedab-4cc2-47d5-8390-85518a34f3bd',
                'codigo': '05',
                'nome': 'teste 5',
              },
            }
          ],
          'grupo_de_recurso': {
            'grupo_de_recurso': '15259eed-653f-4c1a-b0e6-a095332b182a',
            'codigo': '01',
            'nome': 'grupo 01',
            'tipo': 'mao_de_obra'
          }
        }
      ],
      'produtos': [
        {
          'produto_operacao': '960752d8-093f-4693-be22-9c509352c314',
          'operacao': 'ba7e0d9a-493a-49a8-8a62-fb5938138fe2',
          'quantidade': 5.0,
          'tipo_produto': 'insumo',
          'tipo_produto_operacao': 'material_ficha_tecnica',
          'ficha_tecnica_produto': 'aace47ba-c40e-49ae-9fa5-ccef6d5e0f6f',
          'unidade': {
            'unidade': 'fca69f81-ddd6-47ff-ade7-c516488e90ad',
            'codigo': 'LT',
            'nome': 'Litro',
            'decimais': 2,
          },
          'produto': {
            'produto': 'e6aafbcd-2ab7-4c2d-a2c6-0a2899318382',
            'codigo': '03',
            'nome': 'Leite',
          },
        }
      ],
      'centro_de_trabalho': {
        'centro_de_trabalho': '8500df0f-73fa-4b57-9192-6b65402ad6ff',
        'codigo': '1',
        'nome': 'centro de trabalho 07',
      },
    }
  ]
};
