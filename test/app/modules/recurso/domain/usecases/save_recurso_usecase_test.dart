import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/recurso/domain/entities/recurso.dart';
import 'package:pcp_flutter/app/modules/recurso/domain/usecases/save_recurso_usecase.dart';

import '../../utils/recurso_fake.dart';
import '../../utils/recurso_repository_mock.dart';

void main() {
  final repository = RecursoRepositoryMock();
  final usecase = SaveRecursoUsecaseImpl(repository);

  setUpAll(() {
    registerFallbackValue(RecursoFake());

    when(() => repository.insertItem(any()))
        .thenAnswer((_) async => RecursoFake());
    when(() => repository.updateItem(any()))
        .thenAnswer((_) async => RecursoFake());
  });

  test('deve inserir um recurso caso, não tenha id ', () async {
    final recurso = RecursoFake();

    final result = await usecase(recurso);

    expect(result, isA<Recurso>());
    verify(() => repository.insertItem(any()));
    verifyNever(() => repository.updateItem(any()));
  });

  test('deve atualizar o recurso caso tenha id', () async {
    final recurso = RecursoFake(id: 'id');

    final result = await usecase(recurso);

    expect(result, isA<Recurso>());
    verify(() => repository.updateItem(any()));
    verifyNever(() => repository.insertItem(any()));
  });
}
