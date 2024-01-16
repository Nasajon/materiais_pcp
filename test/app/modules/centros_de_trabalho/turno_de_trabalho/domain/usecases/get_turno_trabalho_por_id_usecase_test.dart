import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/get_turno_trabalho_por_id_usecase.dart';

class TurnoTrabalhoRepositoryMock extends Mock implements TurnoTrabalhoRepository {}

void main() {
  late TurnoTrabalhoRepository turnoTrabalhoRepository;
  late GetTurnoTrabalhoPorIdUsecase getTurnoTrabalhoPorIdUsecase;

  setUp(() {
    turnoTrabalhoRepository = TurnoTrabalhoRepositoryMock();
    getTurnoTrabalhoPorIdUsecase = GetTurnoTrabalhoPorIdUsecaseImpl(turnoTrabalhoRepository);
  });

  group('GetTurnoTrabalhoPorIdUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar um TurnoTrabalhoAggregate quando passar o id do turno de trabalho.', () async {
        when(() => turnoTrabalhoRepository.getTurnoTrabalhoPorId('1')).thenAnswer((_) async => TurnoTrabalhoAggregate.empty());

        final response = await getTurnoTrabalhoPorIdUsecase('1');

        expect(response, isA<TurnoTrabalhoAggregate>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundTurnoTrabalhoFailure quando não informar o id do turno de trabalho.', () async {
        expect(() => getTurnoTrabalhoPorIdUsecase(''), throwsA(isA<IdNotFoundTurnoTrabalhoFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => turnoTrabalhoRepository.getTurnoTrabalhoPorId('')).thenThrow(TurnoTrabalhoFailure());

        expect(() => getTurnoTrabalhoPorIdUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
