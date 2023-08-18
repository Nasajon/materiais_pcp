import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_roteiro_por_id_usecase.dart';

class RoteiroRepositoryMock extends Mock implements RoteiroRepository {}

void main() {
  late RoteiroRepository roteiroRepository;
  late GetRoteiroPorIdUsecase getRoteiroPorIdUsecase;

  setUp(() {
    roteiroRepository = RoteiroRepositoryMock();
    getRoteiroPorIdUsecase = GetRoteiroPorIdUsecaseImpl(roteiroRepository);
  });

  group('GetRoteiroPorIdUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar um RoteiroAggregate quando passar o id do roteiro.', () async {
        when(() => roteiroRepository.getRoteiroPorId('1')).thenAnswer((_) async => RoteiroAggregate.empty());

        final response = await getRoteiroPorIdUsecase('1');

        expect(response, isA<RoteiroAggregate>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundRoteiroFailure quando não informar o id do roteiro.', () async {
        expect(() => getRoteiroPorIdUsecase(''), throwsA(isA<IdNotFoundRoteiroFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => roteiroRepository.getRoteiroPorId('')).thenThrow(RoteiroFailure());

        expect(() => getRoteiroPorIdUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
