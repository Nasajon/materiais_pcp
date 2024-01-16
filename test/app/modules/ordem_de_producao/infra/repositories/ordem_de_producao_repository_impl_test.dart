import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_ordem_de_producao_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/ordem_de_producao_repository_impl.dart';

class RemoteOrdemDeProducaoDatasourceMock extends Mock implements RemoteOrdemDeProducaoDatasource {}

void main() {
  late RemoteOrdemDeProducaoDatasource remoteOrdemDeProducaoDatasource;
  late OrdemDeProducaoRepository ordemDeProducaoRepository;

  setUp(() {
    remoteOrdemDeProducaoDatasource = RemoteOrdemDeProducaoDatasourceMock();
    ordemDeProducaoRepository = OrdemDeProducaoRepositoryImpl(remoteOrdemDeProducaoDatasource);
  });

  group('OrdemDeProducaoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('getOrdens - Deve retornar uma lista de ordem de produção recentes quando passar ou não uma pesquisa.', () async {
          when(() => remoteOrdemDeProducaoDatasource.getOrdens()).thenAnswer((invocation) async => <OrdemDeProducaoAggregate>[]);

          final response = await ordemDeProducaoRepository.getOrdens();

          expect(response, isA<List<OrdemDeProducaoAggregate>>());
        });

        test('getOrdemDeProducaoPorId - Deve retornar um OrdemDeProducaoAggregate quando passar o id do ordemDeProducao.', () async {
          when(() => remoteOrdemDeProducaoDatasource.getOrdemDeProducaoPorId('1'))
              .thenAnswer((invocation) async => OrdemDeProducaoAggregate.empty());

          final response = await ordemDeProducaoRepository.getOrdemDeProducaoPorId('1');

          expect(response, isA<OrdemDeProducaoAggregate>());
        });

        test('aprovarOrdemDeProducao - Deve retornar um OrdemDeProducaoAggregate quando passar o id do ordemDeProducao.', () async {
          when(() => remoteOrdemDeProducaoDatasource.aprovarOrdemDeProducao('1')).thenAnswer((invocation) async => true);

          final response = await ordemDeProducaoRepository.aprovarOrdemDeProducao('1');

          expect(response, isA<bool>());
        });

        test('inserir - Deve inserir a ordem de produção e retornar o id quando passar os dados do ordemDeProducao corretos.', () async {
          when(() => remoteOrdemDeProducaoDatasource.inserir(OrdemDeProducaoAggregate.empty()))
              .thenAnswer((invocation) async => OrdemDeProducaoAggregate.empty());

          final response = await ordemDeProducaoRepository.inserir(OrdemDeProducaoAggregate.empty());

          expect(response, isA<OrdemDeProducaoAggregate>());
        });

        test('atualizar - Deve editar a ordem de produção e retornar true quando passar os dados do ordemDeProducao corretos.', () async {
          when(() => remoteOrdemDeProducaoDatasource.atualizar(OrdemDeProducaoAggregate.empty())).thenAnswer((invocation) async => true);

          final response = await ordemDeProducaoRepository.atualizar(OrdemDeProducaoAggregate.empty());

          expect(response, isA<bool>());
          expect(response, true);
        });

        test('deletar - Deve deletar a ordem de produção e retornar true quando passar o id do ordemDeProducao.', () async {
          when(() => remoteOrdemDeProducaoDatasource.deletar('1')).thenAnswer((invocation) async => true);

          final response = await ordemDeProducaoRepository.deletar('1');

          expect(response, isA<bool>());
          expect(response, true);
        });
      });

      group('falha -', () {
        test('getOrdens - Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteOrdemDeProducaoDatasource.getOrdens())
              .thenThrow(DatasourceOrdemDeProducaoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => ordemDeProducaoRepository.getOrdens(), throwsA(isA<OrdemDeProducaoFailure>()));
        });

        test('getOrdemDeProducaoPorId - Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteOrdemDeProducaoDatasource.getOrdemDeProducaoPorId(''))
              .thenThrow(DatasourceOrdemDeProducaoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => ordemDeProducaoRepository.getOrdemDeProducaoPorId(''), throwsA(isA<OrdemDeProducaoFailure>()));
        });

        test('aprovarOrdemDeProducao - Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteOrdemDeProducaoDatasource.aprovarOrdemDeProducao(''))
              .thenThrow(DatasourceOrdemDeProducaoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => ordemDeProducaoRepository.aprovarOrdemDeProducao(''), throwsA(isA<OrdemDeProducaoFailure>()));
        });

        test('inserir - Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteOrdemDeProducaoDatasource.inserir(OrdemDeProducaoAggregate.empty()))
              .thenThrow(DatasourceOrdemDeProducaoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => ordemDeProducaoRepository.inserir(OrdemDeProducaoAggregate.empty()), throwsA(isA<OrdemDeProducaoFailure>()));
        });

        test('atualizar - Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteOrdemDeProducaoDatasource.atualizar(OrdemDeProducaoAggregate.empty()))
              .thenThrow(DatasourceOrdemDeProducaoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => ordemDeProducaoRepository.atualizar(OrdemDeProducaoAggregate.empty()), throwsA(isA<OrdemDeProducaoFailure>()));
        });

        test('deletar - Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteOrdemDeProducaoDatasource.deletar('1'))
              .thenThrow(DatasourceOrdemDeProducaoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => ordemDeProducaoRepository.deletar('1'), throwsA(isA<OrdemDeProducaoFailure>()));
        });
      });
    });
  });
}
