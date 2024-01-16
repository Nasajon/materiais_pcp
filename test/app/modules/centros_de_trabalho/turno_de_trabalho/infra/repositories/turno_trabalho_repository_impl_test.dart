import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/infra/datasources/remote/remote_turno_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/infra/repositories/turno_trabalho_repository_impl.dart';

class RemoteTurnoTrabalhoDatasourceMock extends Mock implements RemoteTurnoTrabalhoDatasource {}

void main() {
  late RemoteTurnoTrabalhoDatasource remoteTurnoTrabalhoDatasource;
  late TurnoTrabalhoRepository turnoTrabalhoRepository;

  setUp(() {
    remoteTurnoTrabalhoDatasource = RemoteTurnoTrabalhoDatasourceMock();
    turnoTrabalhoRepository = TurnoTrabalhoRepositoryImpl(remoteTurnoTrabalhoDatasource);
  });

  group('TurnoTrabalhoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('getTurnoTrabalhoRecentes - Deve retornar uma lista de turno de trabalhos recentes quando o a conexão for remota.', () async {
          when(() => remoteTurnoTrabalhoDatasource.getTurnoTrabalhoRecentes()).thenAnswer((invocation) async => <TurnoTrabalhoAggregate>[]);

          final response = await turnoTrabalhoRepository.getTurnoTrabalhoRecentes();

          expect(response, isA<List<TurnoTrabalhoAggregate>>());
        });

        test('getTurnosTrabalhos - Deve retornar uma lista de turno de trabalhos quando passar ou não uma pesquisa.', () async {
          when(() => remoteTurnoTrabalhoDatasource.getTurnosTrabalhos(search: ''))
              .thenAnswer((invocation) async => <TurnoTrabalhoAggregate>[]);

          final response = await turnoTrabalhoRepository.getTurnosTrabalhos(search: '');

          expect(response, isA<List<TurnoTrabalhoAggregate>>());
        });

        test('getTurnoTrabalhoPorId - Deve retornar um TurnoTrabalhoAggregate quando passar o id do turnoTrabalho.', () async {
          when(() => remoteTurnoTrabalhoDatasource.getTurnoTrabalhoPorId('1'))
              .thenAnswer((invocation) async => TurnoTrabalhoAggregate.empty());

          final response = await turnoTrabalhoRepository.getTurnoTrabalhoPorId('1');

          expect(response, isA<TurnoTrabalhoAggregate>());
        });

        test('inserir - Deve inserir o turno de trabalho e retornar o id quando passar os dados do turnoTrabalho corretos.', () async {
          when(() => remoteTurnoTrabalhoDatasource.inserir(TurnoTrabalhoAggregate.empty()))
              .thenAnswer((invocation) async => TurnoTrabalhoAggregate.empty().copyWith(id: '1'));

          final response = await turnoTrabalhoRepository.inserir(TurnoTrabalhoAggregate.empty());

          expect(response, isA<TurnoTrabalhoAggregate>());
          expect(response.id, '1');
        });

        test('editar - Deve editar o turno de trabalho e retornar true quando passar os dados do turnoTrabalho corretos.', () async {
          when(() => remoteTurnoTrabalhoDatasource.editar(TurnoTrabalhoAggregate.empty())).thenAnswer((invocation) async => true);

          final response = await turnoTrabalhoRepository.editar(TurnoTrabalhoAggregate.empty());

          expect(response, isA<bool>());
          expect(response, true);
        });

        test('deletar - Deve deletar o turno de trabalho e retornar true quando passar o id do turno de trabalho.', () async {
          when(() => remoteTurnoTrabalhoDatasource.deletar('1')).thenAnswer((invocation) async => true);

          final response = await turnoTrabalhoRepository.deletar('1');

          expect(response, isA<bool>());
          expect(response, true);
        });
      });

      group('falha -', () {
        test('getTurnoTrabalhoRecentes - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => remoteTurnoTrabalhoDatasource.getTurnoTrabalhoRecentes())
              .thenThrow(DatasourceTurnoTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => turnoTrabalhoRepository.getTurnoTrabalhoRecentes(), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });

        test('getTurnosTrabalhos - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteTurnoTrabalhoDatasource.getTurnosTrabalhos(search: ''))
              .thenThrow(DatasourceTurnoTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => turnoTrabalhoRepository.getTurnosTrabalhos(search: ''), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });

        test('getTurnoTrabalhoPorId - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.',
            () async {
          when(() => remoteTurnoTrabalhoDatasource.getTurnoTrabalhoPorId(''))
              .thenThrow(DatasourceTurnoTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => turnoTrabalhoRepository.getTurnoTrabalhoPorId(''), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });

        test('inserir - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteTurnoTrabalhoDatasource.inserir(TurnoTrabalhoAggregate.empty()))
              .thenThrow(DatasourceTurnoTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => turnoTrabalhoRepository.inserir(TurnoTrabalhoAggregate.empty()), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });

        test('editar - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteTurnoTrabalhoDatasource.editar(TurnoTrabalhoAggregate.empty()))
              .thenThrow(DatasourceTurnoTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => turnoTrabalhoRepository.editar(TurnoTrabalhoAggregate.empty()), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });

        test('deletar - Deve retornar um DatasourceTurnoTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteTurnoTrabalhoDatasource.deletar('1'))
              .thenThrow(DatasourceTurnoTrabalhoFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => turnoTrabalhoRepository.deletar('1'), throwsA(isA<DatasourceTurnoTrabalhoFailure>()));
        });
      });
    });
  });
}
