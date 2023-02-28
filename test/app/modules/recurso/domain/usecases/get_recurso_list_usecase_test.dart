import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/recurso/domain/entities/recurso.dart';
import 'package:pcp_flutter/app/modules/recurso/domain/usecases/get_recurso_usecase_list.dart';

import '../../utils/recurso_repository_mock.dart';

void main() {
  final repository = RecursoRepositoryMock();
  final usecase = GetGetRecursoListUsecaseImpl(repository);

  test('deve retornar uma lista de recursos com pesquisa', () async {
    when(() => repository.getList(any())).thenAnswer((_) async => []);

    final result = await usecase('test');

    expect(result, isA<List<Recurso>>());
    verify(() => repository.getList(any()));
  });
}
