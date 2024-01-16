import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_todos_ficha_tecnica_usecase.dart';

class FichaTecnicaRepositoryMock extends Mock implements FichaTecnicaRepository {}

void main() {
  late FichaTecnicaRepository fichaTecnicaRepository;
  late GetTodosFichaTecnicaUsecase getTodosFichaTecnicaUsecase;

  setUp(() {
    fichaTecnicaRepository = FichaTecnicaRepositoryMock();
    getTodosFichaTecnicaUsecase = GetTodosFichaTecnicaUsecaseImpl(fichaTecnicaRepository);
  });

  group('GetUnidadeUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista dos tipos de unidades quando passar ou não uma pesquisa.', () async {
        when(() => fichaTecnicaRepository.getTodosFichaTecnica('')).thenAnswer((_) async => <FichaTecnicaAggregate>[]);

        final response = await getTodosFichaTecnicaUsecase('');

        expect(response, isA<List<FichaTecnicaAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => fichaTecnicaRepository.getTodosFichaTecnica('')).thenThrow(FichaTecnicaFailure());

        expect(() => getTodosFichaTecnicaUsecase(''), throwsA(isA<FichaTecnicaFailure>()));
      });
    });
  });
}
