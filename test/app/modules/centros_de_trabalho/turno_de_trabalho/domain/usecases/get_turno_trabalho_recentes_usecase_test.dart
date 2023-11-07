import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/get_turno_trabalho_recentes_usecase.dart';

class TurnoTrabalhoRepositoryMock extends Mock implements TurnoTrabalhoRepository {}

void main() {
  late TurnoTrabalhoRepository turnoTrabalhoRepository;
  late GetTurnoTrabalhoRecenteUsecase getTurnoTrabalhoRecenteUsecase;

  setUp(() {
    turnoTrabalhoRepository = TurnoTrabalhoRepositoryMock();
    getTurnoTrabalhoRecenteUsecase = GetTurnoTrabalhoRecenteUsecaseImpl(turnoTrabalhoRepository);
  });

  group('GetTurnoTrabalhoRecenteUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de turno de trabalhos quando retornar do backend.', () async {
        when(() => turnoTrabalhoRepository.getTurnoTrabalhoRecentes()).thenAnswer((_) async => <TurnoTrabalhoAggregate>[]);

        final response = await getTurnoTrabalhoRecenteUsecase();

        expect(response, isA<List<TurnoTrabalhoAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => turnoTrabalhoRepository.getTurnoTrabalhoRecentes()).thenThrow(TurnoTrabalhoFailure());

        expect(() => getTurnoTrabalhoRecenteUsecase(), throwsA(isA<TurnoTrabalhoFailure>()));
      });
    });
  });
}
