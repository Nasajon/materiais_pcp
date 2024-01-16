import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/datasources/remotes/remote_ficha_tecnica_datasource.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/repositories/ficha_tecnica_repository_impl.dart';

import '../../domain/entities/inserir_atualizar_ficha_tecnica.dart';

class RemoteFichaTecnicaDatasourceMock extends Mock implements RemoteFichaTecnicaDatasource {}

void main() {
  late RemoteFichaTecnicaDatasource remoteFichaTecnicaDatasource;
  late FichaTecnicaRepository fichaTecnicaRepository;

  setUp(() {
    remoteFichaTecnicaDatasource = RemoteFichaTecnicaDatasourceMock();
    fichaTecnicaRepository = FichaTecnicaRepositoryImpl(remoteFichaTecnicaDatasource);
  });
  group('FichaTecnicaRepository - ', () {
    group('AtualizarFichaTecnica -', () {
      group('sucesso -', () {
        test('Deve poder atualizar uma ficha tecnica caso o cadastro esteja correto.', () async {
          when(() => remoteFichaTecnicaDatasource.atualizarFichaTecnica(fichaTecnicaAtualizar)).thenAnswer((_) async => true);

          final response = await fichaTecnicaRepository.atualizarFichaTecnica(fichaTecnicaAtualizar);

          expect(response, isA<bool>());
          expect(response, true);
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceFichaTecnicaFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteFichaTecnicaDatasource.atualizarFichaTecnica(fichaTecnicaAtualizar)).thenThrow(
            DatasourceFichaTecnicaFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => fichaTecnicaRepository.atualizarFichaTecnica(fichaTecnicaAtualizar), throwsA(isA<DatasourceFichaTecnicaFailure>()));
        });
      });
    });

    group('deletarFichaTecnica -', () {
      group('sucesso -', () {
        test('Deve excluir uma ficna tecnica ou ser passado um id.', () async {
          when(() => remoteFichaTecnicaDatasource.deletarFichaTecnica('')).thenAnswer((_) async => true);

          final response = await fichaTecnicaRepository.deletarFichaTecnica('');

          expect(response, isA<bool>());
          expect(response, true);
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceFichaTecnicaFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteFichaTecnicaDatasource.deletarFichaTecnica('')).thenThrow(
            DatasourceFichaTecnicaFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => fichaTecnicaRepository.deletarFichaTecnica(''), throwsA(isA<DatasourceFichaTecnicaFailure>()));
        });
      });
    });

    group('getFichaTecnicaPorId -', () {
      group('sucesso -', () {
        test('Deve retornar uma ficna tecnica ou ser passado um id.', () async {
          when(() => remoteFichaTecnicaDatasource.getFichaTecnicaPorId('')).thenAnswer((_) async => fichaTecnicaAtualizar);
          final response = await fichaTecnicaRepository.getFichaTecnicaPorId('');
          expect(response, isA<FichaTecnicaAggregate>());
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceFichaTecnicaFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteFichaTecnicaDatasource.getFichaTecnicaPorId('')).thenThrow(
            DatasourceFichaTecnicaFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => fichaTecnicaRepository.getFichaTecnicaPorId(''), throwsA(isA<DatasourceFichaTecnicaFailure>()));
        });
      });
    });

    group('getFichaTecnicaRecentes -', () {
      group('sucesso -', () {
        test('Deve retornar uma ficna tecnica ou ser passado um id.', () async {
          when(() => remoteFichaTecnicaDatasource.getFichaTecnicaRecentes()).thenAnswer((_) async => []);
          final response = await fichaTecnicaRepository.getFichaTecnicaRecentes();
          expect(response, isA<List<FichaTecnicaAggregate>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceFichaTecnicaFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteFichaTecnicaDatasource.getFichaTecnicaRecentes()).thenThrow(
            DatasourceFichaTecnicaFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => fichaTecnicaRepository.getFichaTecnicaRecentes(), throwsA(isA<DatasourceFichaTecnicaFailure>()));
        });
      });
    });

    group('getFichaTecnicaRecentes -', () {
      group('sucesso -', () {
        test('Deve retornar uma ficna tecnica ou ser passado um id.', () async {
          when(() => remoteFichaTecnicaDatasource.getTodosFichaTecnica('')).thenAnswer((_) async => []);
          final response = await fichaTecnicaRepository.getTodosFichaTecnica('');
          expect(response, isA<List<FichaTecnicaAggregate>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceFichaTecnicaFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteFichaTecnicaDatasource.getTodosFichaTecnica('')).thenThrow(
            DatasourceFichaTecnicaFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => fichaTecnicaRepository.getTodosFichaTecnica(''), throwsA(isA<DatasourceFichaTecnicaFailure>()));
        });
      });
    });

    group('inserirFichaTecnica -', () {
      group('sucesso -', () {
        test('Deve retornar uma ficna tecnica ou ser passado um id.', () async {
          when(() => remoteFichaTecnicaDatasource.inserirFichaTecnica(fichaTecnicaCriar))
              .thenAnswer((_) async => fichaTecnicaCriar.copyWith(id: '38694f59-d561-43fb-b24d-ccab586f95f9'));
          final response = await fichaTecnicaRepository.inserirFichaTecnica(fichaTecnicaCriar);
          expect(response, isA<FichaTecnicaAggregate>());
          expect(response.id, '38694f59-d561-43fb-b24d-ccab586f95f9');
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceFichaTecnicaFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteFichaTecnicaDatasource.inserirFichaTecnica(fichaTecnicaCriar)).thenThrow(
            DatasourceFichaTecnicaFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => fichaTecnicaRepository.inserirFichaTecnica(fichaTecnicaCriar), throwsA(isA<DatasourceFichaTecnicaFailure>()));
        });
      });
    });
  });
}
