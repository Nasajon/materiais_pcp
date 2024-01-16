import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/infra/datasources/remotes/remote_centro_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/infra/repositories/centro_trabalho_repository_impl.dart';

class RemoteCentroTrabalhoDatasourceMock extends Mock implements RemoteCentroTrabalhoDatasource {}

void main() {
  late RemoteCentroTrabalhoDatasource remoteCentroTrabalhoDatasource;
  late CentroTrabalhoRepository centroTrabalhoRepository;

  setUp(() {
    remoteCentroTrabalhoDatasource = RemoteCentroTrabalhoDatasourceMock();
    centroTrabalhoRepository = CentroTrabalhoRepositoryImpl(remoteCentroTrabalhoDatasource);
  });

  group('CentroTrabalhoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('getCentroTrabalhoRecentes - Deve retornar uma lista de centro de trabalho recentes quando o a conexão for remota.', () async {
          when(() => remoteCentroTrabalhoDatasource.getCentroTrabalhoRecentes())
              .thenAnswer((invocation) async => <CentroTrabalhoAggregate>[]);

          final response = await centroTrabalhoRepository.getCentroTrabalhoRecentes();

          expect(response, isA<List<CentroTrabalhoAggregate>>());
        });

        test('getTodosCentroTrabalho - Deve retornar uma lista de centro de trabalho quando passar ou não uma pesquisa.', () async {
          when(() => remoteCentroTrabalhoDatasource.getTodosCentroTrabalho(''))
              .thenAnswer((invocation) async => <CentroTrabalhoAggregate>[]);

          final response = await centroTrabalhoRepository.getTodosCentroTrabalho('');

          expect(response, isA<List<CentroTrabalhoAggregate>>());
        });

        test('getCentroTrabalhoPorId - Deve retornar um CentroTrabalhoAggregate quando passar o id do centro de trabalho.', () async {
          when(() => remoteCentroTrabalhoDatasource.getCentroTrabalhoPorId('1'))
              .thenAnswer((invocation) async => CentroTrabalhoAggregate.empty());

          final response = await centroTrabalhoRepository.getCentroTrabalhoPorId('1');

          expect(response, isA<CentroTrabalhoAggregate>());
        });

        test('getTurnos - Deve retornar um TurnoTrabalhoEntity quando passar o id ou uma lista de turnos.', () async {
          when(() => remoteCentroTrabalhoDatasource.getTurnos('', [])).thenAnswer((invocation) async => <TurnoTrabalhoEntity>[]);

          final response = await centroTrabalhoRepository.getTurnos('', []);

          expect(response, isA<List<TurnoTrabalhoEntity>>());
        });

        test(
            'inserirCentroTrabalho - Deve inserir o centro de trabalho e retornar o id quando passar os dados do centro de trabalho corretos.',
            () async {
          when(() => remoteCentroTrabalhoDatasource.inserirCentroTrabalho(CentroTrabalhoAggregate.empty()))
              .thenAnswer((invocation) async => CentroTrabalhoAggregate.empty().copyWith(id: '1'));

          final response = await centroTrabalhoRepository.inserirCentroTrabalho(CentroTrabalhoAggregate.empty());

          expect(response, isA<CentroTrabalhoAggregate>());
          expect(response.id, '1');
        });

        test(
            'atualizarCentroTrabalho - Deve editar o centro de trabalho e retornar true quando passar os dados do centroTrabalho corretos.',
            () async {
          when(() => remoteCentroTrabalhoDatasource.atualizarCentroTrabalho(CentroTrabalhoAggregate.empty()))
              .thenAnswer((invocation) async => true);

          final response = await centroTrabalhoRepository.atualizarCentroTrabalho(CentroTrabalhoAggregate.empty());

          expect(response, isA<bool>());
          expect(response, true);
        });

        test('deletarCentroTrabalho - Deve deletar o centro de trabalho e retornar true quando passar o id do centro de trabalho.',
            () async {
          when(() => remoteCentroTrabalhoDatasource.deletarCentroTrabalho('1')).thenAnswer((invocation) async => true);

          final response = await centroTrabalhoRepository.deletarCentroTrabalho('1');

          expect(response, isA<bool>());
          expect(response, true);
        });
      });

      group('falha -', () {
        test('getCentroTrabalhoRecentes - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => remoteCentroTrabalhoDatasource.getCentroTrabalhoRecentes())
              .thenThrow(DatasourceCentroTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => centroTrabalhoRepository.getCentroTrabalhoRecentes(), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('getTodosCentroTrabalho - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => remoteCentroTrabalhoDatasource.getTodosCentroTrabalho(''))
              .thenThrow(DatasourceCentroTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => centroTrabalhoRepository.getTodosCentroTrabalho(''), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('getCentroTrabalhoPorId - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => remoteCentroTrabalhoDatasource.getCentroTrabalhoPorId(''))
              .thenThrow(DatasourceCentroTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => centroTrabalhoRepository.getCentroTrabalhoPorId(''), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('getTurnos - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteCentroTrabalhoDatasource.getTurnos('', []))
              .thenThrow(DatasourceCentroTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => centroTrabalhoRepository.getTurnos('', []), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('inserirCentroTrabalho - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => remoteCentroTrabalhoDatasource.inserirCentroTrabalho(CentroTrabalhoAggregate.empty()))
              .thenThrow(DatasourceCentroTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => centroTrabalhoRepository.inserirCentroTrabalho(CentroTrabalhoAggregate.empty()),
              throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('atualizarCentroTrabalho - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => remoteCentroTrabalhoDatasource.atualizarCentroTrabalho(CentroTrabalhoAggregate.empty()))
              .thenThrow(DatasourceCentroTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => centroTrabalhoRepository.atualizarCentroTrabalho(CentroTrabalhoAggregate.empty()),
              throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });

        test('deletarCentroTrabalho - Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => remoteCentroTrabalhoDatasource.deletarCentroTrabalho('1'))
              .thenThrow(DatasourceCentroTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => centroTrabalhoRepository.deletarCentroTrabalho('1'), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });
      });
    });
  });
}
