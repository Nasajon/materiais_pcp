import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/datasources/remote/remote_ordem_producao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_ordem_de_producao_datasource.dart';

import '../../../../../core/jsons/test_ordem_de_producao_json.dart';

class ClientServiceMock extends Mock implements IClientService {}

class ClientRequestParamsMock extends Mock implements ClientRequestParams {}

void main() {
  late IClientService clientService;
  late RemoteOrdemDeProducaoDatasource remoteOrdemDeProducaoDatasource;

  setUp(() {
    clientService = ClientServiceMock();
    remoteOrdemDeProducaoDatasource = RemoteOrdemDeProducaoDatasourceImpl(clientService);
    registerFallbackValue(ClientRequestParamsMock());
  });

  group('RemoteOrdemDeProducaoDatasourceImpl -', () {
    group('remotes -', () {
      group('sucesso -', () {
        test('getOrdens - Deve retornar uma lista das ordens de producão quando informar ou não uma pesquisa para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: ordemDeProducaoJson, statusCode: 200),
          );

          final response = await remoteOrdemDeProducaoDatasource.getOrdens();

          expect(response, isA<List<OrdemDeProducaoAggregate>>());
        });

        test('getOrdemDeProducaoPorId - Deve retornar uma ordens de producão quando informar id para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => ClientResponse(data: List.from(ordemDeProducaoJson).first, statusCode: 200),
          );

          final response = await remoteOrdemDeProducaoDatasource.getOrdemDeProducaoPorId('1');

          expect(response, isA<OrdemDeProducaoAggregate>());
        });

        test('aprovarOrdemDeProducao - Deve retornar true quando informar id para aprovação da ordem no backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: '', statusCode: 200),
          );

          final response = await remoteOrdemDeProducaoDatasource.aprovarOrdemDeProducao('1');

          expect(response, isA<bool>());
        });

        test('inserir - Deve retornar uma ordens de producão nova quando informar os dados a ser inserido para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => ClientResponse(data: List.from(ordemDeProducaoJson).first, statusCode: 200),
          );

          final response = await remoteOrdemDeProducaoDatasource.inserir(OrdemDeProducaoAggregate.empty());

          expect(response, isA<OrdemDeProducaoAggregate>());
        });

        test('atualizar - Deve retornar uma true quando informar os dados a ser inserido para o backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: '', statusCode: 200),
          );

          final response = await remoteOrdemDeProducaoDatasource.atualizar(OrdemDeProducaoAggregate.empty());

          expect(response, isA<bool>());
        });

        test('atualizar - Deve retornar uma true quando informar o id para deletar a ordem no backend.', () async {
          when(() => clientService.request(any())).thenAnswer(
            (_) async => const ClientResponse(data: '', statusCode: 200),
          );

          final response = await remoteOrdemDeProducaoDatasource.deletar('1');

          expect(response, isA<bool>());
        });
      });

      group('falha -', () {
        test('getOrdens - Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteOrdemDeProducaoDatasource.getOrdens(), throwsA(isA<OrdemDeProducaoFailure>()));
        });

        test('getOrdemDeProducaoPorId - Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteOrdemDeProducaoDatasource.getOrdemDeProducaoPorId('1'), throwsA(isA<OrdemDeProducaoFailure>()));
        });

        test('aprovarOrdemDeProducao - Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteOrdemDeProducaoDatasource.aprovarOrdemDeProducao('1'), throwsA(isA<OrdemDeProducaoFailure>()));
        });

        test('inserir - Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteOrdemDeProducaoDatasource.inserir(OrdemDeProducaoAggregate.empty()), throwsA(isA<OrdemDeProducaoFailure>()));
        });

        test('inserir - Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteOrdemDeProducaoDatasource.atualizar(OrdemDeProducaoAggregate.empty()), throwsA(isA<OrdemDeProducaoFailure>()));
        });

        test('deletar - Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no backend.', () async {
          when(() => clientService.request(any())).thenThrow(
            ClientError(message: 'error', statusCode: 500),
          );

          expect(() => remoteOrdemDeProducaoDatasource.deletar('1'), throwsA(isA<OrdemDeProducaoFailure>()));
        });
      });
    });
  });
}
