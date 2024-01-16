import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/unidade_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/unidade_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/datasources/remotes/remote_unidade_datasource.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/repositories/unidade_repository_impl.dart';

class RemoteUnidadeDatasourceMock extends Mock implements RemoteUnidadeDatasource {}

void main() {
  late RemoteUnidadeDatasource remoteUnidadeDatasource;
  late UnidadeRepository unidadeRepository;

  setUp(() {
    remoteUnidadeDatasource = RemoteUnidadeDatasourceMock();
    unidadeRepository = UnidadeRepositoryImpl(remoteUnidadeDatasource);
  });

  group('UnidadeRepository -', () {
    group('getTodasUnidades -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de unidades  quando informar ou não uma pesquisa.', () async {
          when(() => remoteUnidadeDatasource.getTodasUnidades('')).thenAnswer((_) async => <UnidadeEntity>[]);

          final response = await unidadeRepository.getTodasUnidades('');

          expect(response, isA<List<UnidadeEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceUnidadeFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteUnidadeDatasource.getTodasUnidades('')).thenThrow(
            DatasourceUnidadeFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => unidadeRepository.getTodasUnidades(''), throwsA(isA<DatasourceUnidadeFailure>()));
        });
      });
    });
    group('getTodasUnidadesPorIds -', () {
      group('sucesso -', () {
        test('Deve retornar um mapa de undidades quando pesquisar uma lista de ids.', () async {
          when(() => remoteUnidadeDatasource.getTodasUnidadesPorIds([''])).thenAnswer((_) async => <String, UnidadeEntity>{});

          final response = await unidadeRepository.getTodasUnidadesPorIds(['']);

          expect(response, isA<Map<String, UnidadeEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceUnidadeFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteUnidadeDatasource.getTodasUnidadesPorIds([''])).thenThrow(
            DatasourceUnidadeFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => unidadeRepository.getTodasUnidadesPorIds(['']), throwsA(isA<DatasourceUnidadeFailure>()));
        });
      });
    });
  });
}
