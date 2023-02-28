import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/usecases/get_grupo_de_recurso_list_usecase.dart';

import '../../utils/grupo_de_recursos_repository_mock.dart';

void main() {
  final repository = GrupoDeRecursosRepositoryMock();
  final usecase = GetGrupoDeRecursoListUsecaseImpl(repository);

  test('deve retornar uma lista de grupo de recursos', () async {
    when(() => repository.getList(any())).thenAnswer((_) async => []);

    final result = await usecase();

    expect(result, isA<List<GrupoDeRecurso>>());
    verify(() => repository.getList(any()));
  });
}
