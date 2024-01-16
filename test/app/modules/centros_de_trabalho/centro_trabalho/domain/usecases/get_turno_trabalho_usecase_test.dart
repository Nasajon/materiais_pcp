import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/get_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/get_turno_trabalho_repository.dart';

class GetTurnoTrabalhoRepositoryMock extends Mock implements GetTurnoTrabalhoRepository {}

void main() {
  late GetTurnoTrabalhoRepository turnoTrabalhoRepository;
  late GetTurnoTrabalhoUsecase getTurnoTrabalhoUsecase;

  setUp(() {
    turnoTrabalhoRepository = GetTurnoTrabalhoRepositoryMock();
    getTurnoTrabalhoUsecase = GetTurnoTrabalhoUsecaseImpl(turnoTrabalhoRepository);
  });

  group('GetTurnosTrabalhosUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de turno de trabalhos quando tiver um retorno da camada  inferior.', () async {
        when(() => turnoTrabalhoRepository()).thenAnswer((_) async => <TurnoTrabalhoEntity>[]);

        final response = await getTurnoTrabalhoUsecase();

        expect(response, isA<List<TurnoTrabalhoEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => turnoTrabalhoRepository()).thenThrow(CentroTrabalhoFailure());

        expect(() => getTurnoTrabalhoUsecase(), throwsA(isA<CentroTrabalhoFailure>()));
      });
    });
  });
}
