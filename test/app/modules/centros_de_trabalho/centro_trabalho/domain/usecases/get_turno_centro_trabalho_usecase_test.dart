import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/get_turno_centro_trabalho_usecase.dart';

class TurnoTrabalhoRepositoryMock extends Mock implements CentroTrabalhoRepository {}

void main() {
  late CentroTrabalhoRepository centroTrabalhoRepository;
  late GetTurnoCentroTrabalhoUsecase getTodosTurnoTrabalhoUsecase;

  setUp(() {
    centroTrabalhoRepository = TurnoTrabalhoRepositoryMock();
    getTodosTurnoTrabalhoUsecase = GetTurnoCentroTrabalhoUsecaseImpl(centroTrabalhoRepository);
  });

  group('GetTurnoTrabalhoUsecaseImpl -', () {
    group('Sucesso -', () {
      // TODO: Deve informa de qual entidade é o 'ID'
      test('Deve retornar uma lista de turno de trabalhos quando passar o id.', () async {
        when(() => centroTrabalhoRepository.getTurnos('1', [])).thenAnswer((_) async => <TurnoTrabalhoEntity>[]);

        final response = await getTodosTurnoTrabalhoUsecase('1', []);

        expect(response, isA<List<TurnoTrabalhoEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar um IdNotFoundCentroTrabalhoFailure quando não informa o id.', () async {
        expect(() => getTodosTurnoTrabalhoUsecase('', []), throwsA(isA<IdNotFoundCentroTrabalhoFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => centroTrabalhoRepository.getTurnos('1', [])).thenThrow(CentroTrabalhoFailure());

        expect(() => getTodosTurnoTrabalhoUsecase('1', []), throwsA(isA<CentroTrabalhoFailure>()));
      });
    });
  });
}
