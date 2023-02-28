import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/usecases/save_grupo_de_recurso_usecase.dart';

import '../../utils/grupo_de_recurso_fake.dart';
import '../../utils/grupo_de_recursos_repository_mock.dart';

void main() {
  final repository = GrupoDeRecursosRepositoryMock();
  final usecase = SaveGrupoDeRecursoUsecaseImpl(repository);

  setUpAll(() {
    registerFallbackValue(GrupoDeRecursoFake());

    when(() => repository.insertItem(any()))
        .thenAnswer((_) async => GrupoDeRecursoFake());
    when(() => repository.updateItem(any()))
        .thenAnswer((_) async => GrupoDeRecursoFake());
  });

  test('deve inserir um novo grupo de recurso caso, não tenha id ', () async {
    final grupoDeRecurso = GrupoDeRecursoFake();

    final result = await usecase(grupoDeRecurso);

    expect(result, isA<GrupoDeRecurso>());
    verify(() => repository.insertItem(any()));
    verifyNever(() => repository.updateItem(any()));
  });

  test('deve atualizar o grupo de recurso caso tenha id', () async {
    final grupoDeRecurso = GrupoDeRecursoFake(id: 'test');

    final result = await usecase(grupoDeRecurso);

    expect(result, isA<GrupoDeRecurso>());
    verify(() => repository.updateItem(any()));
    verifyNever(() => repository.insertItem(any()));
  });
}
