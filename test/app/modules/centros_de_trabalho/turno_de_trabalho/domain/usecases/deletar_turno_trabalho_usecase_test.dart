import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/deletar_turno_trabalho_usecase.dart';

class TurnoTrabalhoRepositoryMock extends Mock implements TurnoTrabalhoRepository {}

void main() {
  late TurnoTrabalhoRepository turnoTrabalhoRepository;
  late DeletarTurnoTrabalhoUsecase deletarTurnoTrabalhoUsecase;

  setUp(() {
    turnoTrabalhoRepository = TurnoTrabalhoRepositoryMock();
    deletarTurnoTrabalhoUsecase = DeletarTurnoTrabalhoUsecaseImpl(turnoTrabalhoRepository);
  });

  group('GetRestricaoByGrupoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve deletar um turnoTrabalho quando passar o id para o backend.', () async {
        when(() => turnoTrabalhoRepository.deletar('1')).thenAnswer((_) async => true);

        final response = await deletarTurnoTrabalhoUsecase('1');

        expect(response, isA<bool>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundTurnoTrabalhoFailure quando não informar o id do turnoTrabalho.', () async {
        expect(() => deletarTurnoTrabalhoUsecase(''), throwsA(isA<IdNotFoundTurnoTrabalhoFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => turnoTrabalhoRepository.deletar('')).thenThrow(TurnoTrabalhoFailure());

        expect(() => deletarTurnoTrabalhoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
