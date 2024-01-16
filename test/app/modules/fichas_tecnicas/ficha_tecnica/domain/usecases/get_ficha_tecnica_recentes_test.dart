import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_ficha_tecnica_recentes_usecase.dart';

class FichaTecnicaRepositoryMock extends Mock implements FichaTecnicaRepository {}

void main() {
  late FichaTecnicaRepository fichaTecnicaRepository;
  late GetFichaTecnicaRecenteUsecase getFichaTecnicaRecentsUsecase;

  setUp(() {
    fichaTecnicaRepository = FichaTecnicaRepositoryMock();
    getFichaTecnicaRecentsUsecase = GetFichaTecnicaRecenteUsecaseImpl(fichaTecnicaRepository);
  });

  group('GetFichaTecnicaRecenteUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de ficha tecnicas quando retornar do backend.', () async {
        when(() => fichaTecnicaRepository.getFichaTecnicaRecentes()).thenAnswer((_) async => <FichaTecnicaAggregate>[]);

        final response = await getFichaTecnicaRecentsUsecase();

        expect(response, isA<List<FichaTecnicaAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => fichaTecnicaRepository.getFichaTecnicaRecentes()).thenThrow(FichaTecnicaFailure());

        expect(() => getFichaTecnicaRecentsUsecase(), throwsA(isA<FichaTecnicaFailure>()));
      });
    });
  });
}
