import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_get_operacao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_operacao_datasource.dart';

import '../../../../../core/jsons/test_roteiro_json.dart';

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
            (_) async => const ClientResponse(data: roteiroJson, statusCode: 200),
          );

          final response = await remoteGetOperacaoDatasource(['1']);

          expect(response, isA<List<OperacaoAggregate>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteGetOperacaoDatasource([]), throwsA(isA<OrdemDeProducaoFailure>()));
        });
      });
    });
  });
}
