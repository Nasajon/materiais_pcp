import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_roteiro_usecase.dart';

class RoteiroRepositoryMock extends Mock implements RoteiroRepository {}

void main() {
  late RoteiroRepository roteiroRepository;
  late GetRoteiroUsecase getRoteiroUsecase;

  setUp(() {
    roteiroRepository = RoteiroRepositoryMock();
    getRoteiroUsecase = GetRoteiroUsecaseImpl(roteiroRepository);
  });

  group('GetRoteiroUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de roteiros quando passar ou não uma pesquisa.', () async {
        when(() => roteiroRepository.getRoteiro('')).thenAnswer((_) async => <RoteiroEntity>[]);

        final response = await getRoteiroUsecase('');

        expect(response, isA<List<RoteiroEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => roteiroRepository.getRoteiro('')).thenThrow(RoteiroFailure());

        expect(() => getRoteiroUsecase(''), throwsA(isA<RoteiroFailure>()));
      });
    });
  });
}
