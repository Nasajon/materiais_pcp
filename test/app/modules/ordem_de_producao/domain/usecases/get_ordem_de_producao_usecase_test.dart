import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_ordem_de_producao_usecase.dart';

class OrdemDeProducaoRepositoryMock extends Mock implements OrdemDeProducaoRepository {}

void main() {
  late OrdemDeProducaoRepository ordemDeProducaoRepository;
  late GetOrdemDeProducaoUsecase getOrdemDeProducaoUsecase;

  setUp(() {
    ordemDeProducaoRepository = OrdemDeProducaoRepositoryMock();
    getOrdemDeProducaoUsecase = GetOrdemDeProducaoUsecaseImpl(ordemDeProducaoRepository: ordemDeProducaoRepository);
  });

  group('GetOrdemDeProducaoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de ordem de produção quando passar ou não uma pesquisa.', () async {
        when(() => ordemDeProducaoRepository.getOrdens()).thenAnswer((_) async => <OrdemDeProducaoAggregate>[]);

        final response = await getOrdemDeProducaoUsecase();

        expect(response, isA<List<OrdemDeProducaoAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma OrdemDeProducaoFailure quando ocorrer um erro na pesquisa.', () async {
        when(() => ordemDeProducaoRepository.getOrdens()).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => getOrdemDeProducaoUsecase(), throwsA(isA<OrdemDeProducaoFailure>()));
      });
    });
  });
}
