import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/get_centro_trabalho_recente_usecase.dart';

class CentroTrabalhoRepositoryMock extends Mock implements CentroTrabalhoRepository {}

void main() {
  late CentroTrabalhoRepository centroTrabalhoRepository;
  late GetCentroTrabalhoRecenteUsecase getCentroTrabalhoRecenteUsecase;

  setUp(() {
    centroTrabalhoRepository = CentroTrabalhoRepositoryMock();
    getCentroTrabalhoRecenteUsecase = GetCentroTrabalhoRecenteUsecaseImpl(centroTrabalhoRepository);
  });

  group('GetCentroTrabalhoRecenteUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista do centro de trabalhos quando retornar do backend.', () async {
        when(() => centroTrabalhoRepository.getCentroTrabalhoRecentes()).thenAnswer((_) async => <CentroTrabalhoAggregate>[]);

        final response = await getCentroTrabalhoRecenteUsecase();

        expect(response, isA<List<CentroTrabalhoAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => centroTrabalhoRepository.getCentroTrabalhoRecentes()).thenThrow(CentroTrabalhoFailure());

        expect(() => getCentroTrabalhoRecenteUsecase(), throwsA(isA<CentroTrabalhoFailure>()));
      });
    });
  });
}
