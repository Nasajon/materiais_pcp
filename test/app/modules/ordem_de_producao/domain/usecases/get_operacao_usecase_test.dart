import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_operacao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_operacao_usecase.dart';

class GetOperacaoRepositoryMock extends Mock implements GetOperacaoRepository {}

void main() {
  late GetOperacaoRepository getOperacaoRepository;
  late GetOperacaoUsecase getOperacaoUsecase;

  setUp(() {
    getOperacaoRepository = GetOperacaoRepositoryMock();
    getOperacaoUsecase = GetOperacaoUsecaseImpl(getOperacaoRepository: getOperacaoRepository);
  });

  group('GetOperacaoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de produto quando passar ou não uma pesquisa.', () async {
        when(() => getOperacaoRepository(['1'])).thenAnswer((_) async => <OperacaoAggregate>[]);

        final response = await getOperacaoUsecase(['1']);

        expect(response, isA<List<OperacaoAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma OrdemDeProducaoFailure quando não informar o id do roteiro.', () async {
        expect(() => getOperacaoUsecase([]), throwsA(isA<OrdemDeProducaoFailure>()));
      });

      test('Deve retornar uma OrdemDeProducaoFailure quando ocorrer um erro na pesquisa.', () async {
        when(() => getOperacaoRepository(['1'])).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => getOperacaoUsecase(['1']), throwsA(isA<OrdemDeProducaoFailure>()));
      });
    });
  });
}
