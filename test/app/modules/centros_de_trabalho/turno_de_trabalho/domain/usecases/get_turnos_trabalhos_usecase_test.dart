import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/get_turnos_trabalhos_usecase.dart';

class TurnoTrabalhoRepositoryMock extends Mock implements TurnoTrabalhoRepository {}

void main() {
  late TurnoTrabalhoRepository turnoTrabalhoRepository;
  late GetTurnosTrabalhosUsecase getTurnoTrabalhoUsecase;

  setUp(() {
    turnoTrabalhoRepository = TurnoTrabalhoRepositoryMock();
    getTurnoTrabalhoUsecase = GetTurnosTrabalhosUsecaseImpl(turnoTrabalhoRepository);
  });

  group('GetTurnosTrabalhosUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de turno de trabalhos quando passar ou não uma pesquisa.', () async {
        when(() => turnoTrabalhoRepository.getTurnosTrabalhos(search: '')).thenAnswer((_) async => <TurnoTrabalhoAggregate>[]);

        final response = await getTurnoTrabalhoUsecase(search: '');

        expect(response, isA<List<TurnoTrabalhoAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => turnoTrabalhoRepository.getTurnosTrabalhos(search: '')).thenThrow(TurnoTrabalhoFailure());

        expect(() => getTurnoTrabalhoUsecase(search: ''), throwsA(isA<TurnoTrabalhoFailure>()));
      });
    });
  });
}
