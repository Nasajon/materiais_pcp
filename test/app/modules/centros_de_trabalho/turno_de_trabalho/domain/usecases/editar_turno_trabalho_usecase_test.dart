import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/entities/horario_entity.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/types/dias_da_semana_type.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/editar_turno_trabalho_usecase.dart';

class TurnoTrabalhoRepositoryMock extends Mock implements TurnoTrabalhoRepository {}

void main() {
  late TurnoTrabalhoRepository turnoTrabalhoRepository;
  late EditarTurnoTrabalhoUsecase editarTurnoTrabalhoUsecase;

  setUp(() {
    turnoTrabalhoRepository = TurnoTrabalhoRepositoryMock();
    editarTurnoTrabalhoUsecase = EditarTurnoTrabalhoUsecaseImpl(turnoTrabalhoRepository);
  });

  group('EditarTurnoTrabalhoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve editar um turno de trabalho quando os dados forem valido.', () async {
        when(() => turnoTrabalhoRepository.editar(turnoTrabalho)).thenAnswer((_) async => true);

        final response = await editarTurnoTrabalhoUsecase(turnoTrabalho);

        expect(response, isA<bool>());
        expect(response, true);
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro TurnoTrabalhoIsNotValidFailure quando os dados não são valido.', () async {
        expect(() => editarTurnoTrabalhoUsecase(TurnoTrabalhoAggregate.empty()), throwsA(isA<TurnoTrabalhoIsNotValidFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => turnoTrabalhoRepository.editar(turnoTrabalho)).thenThrow(TurnoTrabalhoFailure());

        expect(() => editarTurnoTrabalhoUsecase(turnoTrabalho), throwsA(isA<Failure>()));
      });
    });
  });
}

final turnoTrabalho = TurnoTrabalhoAggregate(
  id: '1',
  codigo: CodigoVO(1),
  nome: TextVO('Teste'),
  horarios: [
    HorarioEntity(
      codigo: 1,
      diasDaSemana: [DiasDaSemanaType.friday],
      horarioInicial: TimeVO('00:00'),
      horarioFinal: TimeVO('00:00'),
      intervalo: TimeVO('00:00'),
    )
  ],
);
