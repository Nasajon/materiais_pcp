import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/recurso/domain/errors/recurso_failures.dart';
import 'package:pcp_flutter/app/modules/recurso/domain/usecases/get_recurso_by_usecase_id.dart';

import '../../utils/recurso_factory.dart';
import '../../utils/recurso_repository_mock.dart';

void main() {
  final repository = RecursoRepositoryMock();
  final usecase = GetRecursoByIdUsecaseImpl(repository);
  final recurso = RecursoFactory.create();

  test('deve retornar um recurso', () async {
    when(() => repository.getItem(any())).thenAnswer((_) async => recurso);

    final result = await usecase('id');

    expect(result, recurso);

    verify(() => repository.getItem(any()));
  });

  test('deve retornar um RecursoInvalidIdError caso o texto seja vazio',
      () async {
    when(() => repository.getItem(any())).thenAnswer((_) async => recurso);

    try {
      await usecase('');

      fail("exception not thrown");
    } catch (e) {
      expect(e, isA<RecursoInvalidIdError>());
    }

    verifyNever(() => repository.getItem(any()));
  });
}
