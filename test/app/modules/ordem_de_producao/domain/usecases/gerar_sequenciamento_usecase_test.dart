import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/dto/sequenciamento_dto.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/sequenciamento_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/gerar_sequenciamento_usecase.dart';

class SequenciamentoRepositoryMock extends Mock implements SequenciamentoRepository {}

void main() {
  late SequenciamentoRepository sequenciamentoRepository;
  late GerarSequenciamentoUsecase gerarSequenciamentoUsecase;

  setUp(() {
    sequenciamentoRepository = SequenciamentoRepositoryMock();
    gerarSequenciamentoUsecase = GerarSequenciamentoUsecaseImpl(sequenciamentoRepository: sequenciamentoRepository);
  });

  group('GerarSequenciamentoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve gerar o sequenciamento de uma ordem de producao quando passar o retorno do sequenciamento do backend.', () async {
        const sequenciamento = SequenciamentoDTO(
          ordensIds: ['1'],
          recursosIds: ['1'],
          restricoesIds: [''],
        );

        when(() => sequenciamentoRepository.gerarSequencimaneto(sequenciamento)).thenAnswer((_) async => SequenciamentoAggregate.empty());

        final response = await gerarSequenciamentoUsecase(sequenciamento);

        expect(response, isA<SequenciamentoAggregate>());
      });
    });

    group('Falha -', () {
      // test('Deve retornar o erro Failure quando não informar o id do ordemDeProducao.', () async {
      //   expect(() => gerarSequenciamentoUsecase(SequenciamentoAggregate.empty()),
      //       throwsA(isA<IdNotFoundFailure>()));
      // });

      test('Deve retornar um Failure quando ocorrer um erro no repository.', () async {
        const sequenciamento = SequenciamentoDTO(ordensIds: [], recursosIds: [], restricoesIds: []);
        when(() => sequenciamentoRepository.gerarSequencimaneto(sequenciamento)).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => gerarSequenciamentoUsecase(sequenciamento), throwsA(isA<OrdemDeProducaoFailure>()));
      });
    });
  });
}
