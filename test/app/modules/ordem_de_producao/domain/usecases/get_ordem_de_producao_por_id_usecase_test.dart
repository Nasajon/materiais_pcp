import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_ordem_de_producao_por_id_usecase.dart';

class OrdemDeProducaoRepositoryMock extends Mock implements OrdemDeProducaoRepository {}

void main() {
  late OrdemDeProducaoRepository ordemDeProducaoRepository;
  late GetOrdemDeProducaoPorIdUsecase getOrdemDeProducaoPorIdUsecase;

  setUp(() {
    ordemDeProducaoRepository = OrdemDeProducaoRepositoryMock();
    getOrdemDeProducaoPorIdUsecase = GetOrdemDeProducaoPorIdUsecaseImpl(ordemDeProducaoRepository);
  });

  group('GetOrdemDeProducaoPorIdUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar um objeto da ordem de produção quando passar informar o id para o backend.', () async {
        when(() => ordemDeProducaoRepository.getOrdemDeProducaoPorId('1')).thenAnswer((_) async => OrdemDeProducaoAggregate.empty());

        final response = await getOrdemDeProducaoPorIdUsecase('1');

        expect(response, isA<OrdemDeProducaoAggregate>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro OrdemDeProducaoFailure quando não informar o id do ordemDeProducao.', () async {
        expect(() => getOrdemDeProducaoPorIdUsecase(''), throwsA(isA<IdNotFoundOrdemDeProducaoFailure>()));
      });

      test('Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no repository.', () async {
        when(() => ordemDeProducaoRepository.deletar('')).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => getOrdemDeProducaoPorIdUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
