import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_recurso_por_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_recurso_por_grupo_usecase.dart';

class GetRecursoPorGrupoRepositoryMock extends Mock implements GetRecursoPorGrupoRepository {}

void main() {
  late GetRecursoPorGrupoRepository getRecursoRepository;
  late GetRecursoPorGrupoUsecase getRecursoUsecase;

  setUp(() {
    getRecursoRepository = GetRecursoPorGrupoRepositoryMock();
    getRecursoUsecase = GetRecursoPorGrupoUsecaseImpl(getRecursoRepository);
  });

  group('GetRecursoPorGrupoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de recurso quando passar o id do grupo de recurso.', () async {
        when(() => getRecursoRepository('1')).thenAnswer((_) async => <RecursoAggregate>[]);

        final response = await getRecursoUsecase('1');

        expect(response, isA<List<RecursoAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundRoteiroFailure quando não informar o id do grupo de recurso.', () async {
        expect(() => getRecursoUsecase(''), throwsA(isA<IdNotFoundRoteiroFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => getRecursoRepository('')).thenThrow(RoteiroFailure());

        expect(() => getRecursoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
