import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_roteiro_recente_usecase.dart';

class RoteiroRepositoryMock extends Mock implements RoteiroRepository {}

void main() {
  late RoteiroRepository roteiroRepository;
  late GetRoteiroRecenteUsecase getRoteiroRecenteUsecase;

  setUp(() {
    roteiroRepository = RoteiroRepositoryMock();
    getRoteiroRecenteUsecase = GetRoteiroRecenteUsecaseImpl(roteiroRepository);
  });

  group('GetRoteiroRecenteUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de roteiros quando retornar do backend.', () async {
        when(() => roteiroRepository.getRoteiroRecente()).thenAnswer((_) async => <RoteiroEntity>[]);

        final response = await getRoteiroRecenteUsecase();

        expect(response, isA<List<RoteiroEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => roteiroRepository.getRoteiroRecente()).thenThrow(RoteiroFailure());

        expect(() => getRoteiroRecenteUsecase(), throwsA(isA<RoteiroFailure>()));
      });
    });
  });
}
