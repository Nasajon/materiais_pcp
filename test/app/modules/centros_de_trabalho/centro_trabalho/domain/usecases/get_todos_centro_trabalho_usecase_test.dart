import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/get_todos_centro_trabalho_usecase.dart';

class CentroTrabalhoRepositoryMock extends Mock implements CentroTrabalhoRepository {}

void main() {
  late CentroTrabalhoRepository centroTrabalhoRepository;
  late GetTodosCentroTrabalhoUsecase getTodosCentroTrabalhoUsecase;

  setUp(() {
    centroTrabalhoRepository = CentroTrabalhoRepositoryMock();
    getTodosCentroTrabalhoUsecase = GetTodosCentroTrabalhoUsecaseImpl(centroTrabalhoRepository);
  });

  group('GetTodosCentroTrabalhoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista do centro de trabalhos quando passar ou não uma pesquisa.', () async {
        when(() => centroTrabalhoRepository.getTodosCentroTrabalho('')).thenAnswer((_) async => <CentroTrabalhoAggregate>[]);

        final response = await getTodosCentroTrabalhoUsecase('');

        expect(response, isA<List<CentroTrabalhoAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => centroTrabalhoRepository.getTodosCentroTrabalho('')).thenThrow(CentroTrabalhoFailure());

        expect(() => getTodosCentroTrabalhoUsecase(''), throwsA(isA<CentroTrabalhoFailure>()));
      });
    });
  });
}
