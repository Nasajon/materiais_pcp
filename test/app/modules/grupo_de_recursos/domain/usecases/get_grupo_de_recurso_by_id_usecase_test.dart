import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/errors/grupo_de_recursos_failures.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/usecases/get_grupo_de_recurso_by_id_usecase.dart';

import '../../utils/grupo_de_recurso_factory.dart';
import '../../utils/grupo_de_recursos_repository_mock.dart';

void main() {
  final repository = GrupoDeRecursosRepositoryMock();
  final usecase = GetGrupoDeRecursoByIdUsecaseImpl(repository);
  final grupoDeRecurso = GrupoDeRecursoFactory.create();

  test('deve retornar um grupo de recurso', () async {
    when(() => repository.getItem(any()))
        .thenAnswer((_) async => grupoDeRecurso);

    final result = await usecase('id');

    expect(result, grupoDeRecurso);

    verify(() => repository.getItem(any()));
  });

  test('deve retornar um GrupoDeRecursosInvalidIdError caso o texto seja vazio',
      () async {
    when(() => repository.getItem(any()))
        .thenAnswer((_) async => grupoDeRecurso);

    try {
      await usecase('');

      fail("exception not thrown");
    } catch (e) {
      expect(e, isA<GrupoDeRecursosInvalidIdError>());
    }

    verifyNever(() => repository.getItem(any()));
  });
}
