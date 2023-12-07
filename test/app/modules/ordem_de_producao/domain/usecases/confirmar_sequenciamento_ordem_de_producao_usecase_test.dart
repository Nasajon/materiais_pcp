import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/sequenciamento_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/confirmar_sequenciamento_ordem_de_producao_usecase.dart';

class SequenciamentoRepositoryMock extends Mock implements SequenciamentoRepository {}

void main() {
  late SequenciamentoRepository sequenciamentoRepository;
  late ConfirmarSequenciamentoOrdemDeProducaoUsecase confirmarSequenciamentoOrdemDeProducaoUsecase;

  setUp(() {
    sequenciamentoRepository = SequenciamentoRepositoryMock();
    confirmarSequenciamentoOrdemDeProducaoUsecase =
        ConfirmarSequenciamentoOrdemDeProducaoUsecaseImpl(sequenciamentoRepository: sequenciamentoRepository);
  });

  group('ConfirmarSequenciamentoOrdemDeProducaoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve confirmar o sequenciamento de uma ordem de producao quando passar o retorno do sequenciamento do backend.', () async {
        when(() => sequenciamentoRepository.sequenciarOrdemDeProducao(SequenciamentoAggregate.empty())).thenAnswer((_) async => true);

        final response = await confirmarSequenciamentoOrdemDeProducaoUsecase(SequenciamentoAggregate.empty());

        expect(response, isA<bool>());
      });
    });

    group('Falha -', () {
      // test('Deve retornar o erro OrdemDeProducaoFailure quando não informar o id do ordemDeProducao.', () async {
      //   expect(() => confirmarSequenciamentoOrdemDeProducaoUsecase(SequenciamentoAggregate.empty()),
      //       throwsA(isA<IdNotFoundOrdemDeProducaoFailure>()));
      // });

      test('Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no repository.', () async {
        when(() => sequenciamentoRepository.sequenciarOrdemDeProducao(SequenciamentoAggregate.empty()))
            .thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(
            () => confirmarSequenciamentoOrdemDeProducaoUsecase(SequenciamentoAggregate.empty()), throwsA(isA<OrdemDeProducaoFailure>()));
      });
    });
  });
}
