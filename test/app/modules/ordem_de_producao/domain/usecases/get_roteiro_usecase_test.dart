import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_roteiro_usecase.dart';

class GetRoteiroRepositoryMock extends Mock implements GetRoteiroRepository {}

void main() {
  late GetRoteiroRepository getRoteiroRepository;
  late GetRoteiroUsecase getRoteiroUsecase;

  setUp(() {
    getRoteiroRepository = GetRoteiroRepositoryMock();
    getRoteiroUsecase = GetRoteiroUsecaseImpl(getRoteiroRepository);
  });

  group('GetRoteiroUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de roteiro quando passar ou não uma pesquisa.', () async {
        when(() => getRoteiroRepository('1', search: '')).thenAnswer((_) async => <RoteiroEntity>[RoteiroEntity.empty()]);

        final response = await getRoteiroUsecase('1', search: '');

        expect(response, isA<List<RoteiroEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar um OrdemDeProducaoFailure quando a pesquisa pelo produto não tiver resultado.', () async {
        when(() => getRoteiroRepository('1', search: '')).thenAnswer((invocation) async => []);

        expect(() => getRoteiroUsecase('1', search: ''), throwsA(isA<OrdemDeProducaoFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => getRoteiroRepository('1', search: '')).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => getRoteiroUsecase('1', search: ''), throwsA(isA<OrdemDeProducaoFailure>()));
      });
    });
  });
}
