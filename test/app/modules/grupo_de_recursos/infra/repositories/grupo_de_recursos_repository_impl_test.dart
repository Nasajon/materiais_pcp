import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/infra/datasources/grupo_de_recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/infra/repositories/grupo_de_recurso_repository_impl.dart';

import '../../utils/grupo_de_recurso_factory.dart';
import '../../utils/grupo_de_recurso_fake.dart';

class GrupoDeRecursoDatasourceMock extends Mock
    implements GrupoDeRecursoDatasource {}

void main() {
  final datasource = GrupoDeRecursoDatasourceMock();
  final repository = GrupoDeRecursoRepositoryImpl(datasource);

  setUpAll(() {
    registerFallbackValue(GrupoDeRecursoFake());
  });

  group('get list', () {
    test('deve retornar uma lista de grupo de recursos', () async {
      when(() => datasource.getList(any()))
          .thenAnswer((_) async => <GrupoDeRecurso>[]);

      final result = await repository.getList('test');

      expect(result, isA<List<GrupoDeRecurso>>());
      verify(() => datasource.getList(any()));
    });

    test('deve retornar um UnknownError se o datasorce lançar uma Exception',
        () async {
      when(() => datasource.getList(any())).thenThrow(Exception());

      try {
        await repository.getList('test');

        fail("exception not thrown");
      } catch (e) {
        expect(e, isA<UnknownError>());
      }

      verify(() => datasource.getList(any()));
    });
  });

  group('get item', () {
    final grupoDeRecurso = GrupoDeRecursoFactory.create();

    test('deve retornar um grupo de recurso', () async {
      when(() => datasource.getItem(any()))
          .thenAnswer((_) async => grupoDeRecurso);

      final result = await repository.getItem('');

      expect(result, grupoDeRecurso);

      verify(() => datasource.getItem(any()));
    });

    test('deve retornar um UnknownError se o datasorce lançar uma Exception',
        () async {
      when(() => datasource.getItem(any())).thenThrow(Exception());

      try {
        await repository.getItem('');

        fail("exception not thrown");
      } catch (e) {
        expect(e, isA<UnknownError>());
      }

      verify(() => datasource.getItem(any()));
    });
  });

  group('insert item', () {
    test('deve inserir um grupo de recurso', () async {
      final grupoDeRecurso = GrupoDeRecursoFake();

      when(() => datasource.insertItem(any()))
          .thenAnswer((_) async => grupoDeRecurso);

      final result = await repository.insertItem(grupoDeRecurso);

      expect(result, isA<GrupoDeRecurso>());
      verify(() => datasource.insertItem(any()));
    });
  });

  group('update item', () {
    test('deve atualizar um grupo de recurso', () async {
      final grupoDeRecurso = GrupoDeRecursoFake(id: 'test');

      when(() => datasource.updateItem(any()))
          .thenAnswer((_) async => grupoDeRecurso);

      final result = await repository.updateItem(grupoDeRecurso);

      expect(result, isA<GrupoDeRecurso>());
      verify(() => datasource.updateItem(any()));
    });
  });
}
