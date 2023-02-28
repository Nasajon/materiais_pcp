import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/core/modules/tipo_de_recurso/domain/entities/tipo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recurso/domain/entities/recurso.dart';
import 'package:pcp_flutter/app/modules/recurso/infra/datasources/recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/recurso/infra/repositories/recurso_repository_impl.dart';

import '../../utils/recurso_fake.dart';

class RecursoDatasourceMock extends Mock implements RecursoDatasource {}

void main() {
  final datasource = RecursoDatasourceMock();
  final repository = RecursoRepositoryImpl(datasource);

  setUpAll(() {
    registerFallbackValue(RecursoFake());
  });

  group('get list', () {
    test('deve retornar uma lista de recursos', () async {
      when(() => datasource.getList(any()))
          .thenAnswer((_) async => <Recurso>[]);

      final result = await repository.getList('test');

      expect(result, isA<List<Recurso>>());
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
    final recurso = Recurso(
        codigo: 'test', descricao: 'test', tipo: TipoDeRecurso.equipamento());

    test('deve retornar um recurso', () async {
      when(() => datasource.getItem(any())).thenAnswer((_) async => recurso);

      final result = await repository.getItem('');

      expect(result, recurso);

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
    test('deve inserir um recurso', () async {
      final recurso = RecursoFake();

      when(() => datasource.insertItem(any())).thenAnswer((_) async => recurso);

      await repository.insertItem(recurso);

      verify(() => datasource.insertItem(any()));
    });
  });

  group('update item', () {
    test('deve atualizar um recurso', () async {
      final recurso = RecursoFake(id: 'test');

      when(() => datasource.updateItem(any())).thenAnswer((_) async => recurso);

      await repository.updateItem(recurso);

      verify(() => datasource.updateItem(any()));
    });
  });
}
