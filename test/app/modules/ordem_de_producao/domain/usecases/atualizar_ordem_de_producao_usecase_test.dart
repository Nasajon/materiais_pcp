import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/prioridade_enum.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/atualizar_ordem_de_producao_usecase.dart';

class OrdemDeProducaoRepositoryMock extends Mock implements OrdemDeProducaoRepository {}

void main() {
  late OrdemDeProducaoRepository ordemDeProducaoRepository;
  late AtualizarOrdemDeProducaoUsecase atualizarOrdemDeProducaoUsecase;

  setUp(() {
    ordemDeProducaoRepository = OrdemDeProducaoRepositoryMock();
    atualizarOrdemDeProducaoUsecase = AtualizarOrdemDeProducaoUsecaseImpl(ordemDeProducaoRepository);
  });

  group('AtualizarOrdemDeProducaoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve atualizar uma ordem de producao quando os dados forem valido.', () async {
        when(() => ordemDeProducaoRepository.atualizar(ordemDeProducao)).thenAnswer((_) async => true);

        final response = await atualizarOrdemDeProducaoUsecase(ordemDeProducao);

        expect(response, isA<bool>());
        expect(response, true);
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro OrdemDeProducaoFailure quando os dados não são valido.', () async {
        expect(() => atualizarOrdemDeProducaoUsecase(OrdemDeProducaoAggregate.empty()), throwsA(isA<OrdemDeProducaoFailure>()));
      });

      test('Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no repository.', () async {
        when(() => ordemDeProducaoRepository.atualizar(ordemDeProducao)).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => atualizarOrdemDeProducaoUsecase(ordemDeProducao), throwsA(isA<OrdemDeProducaoFailure>()));
      });
    });
  });
}

final ordemDeProducao = OrdemDeProducaoAggregate(
  id: '1',
  codigo: CodigoVO(1),
  produto: const ProdutoEntity(
    id: '1',
    codigo: '1',
    nome: 'Teste',
  ),
  roteiro: const RoteiroEntity(
    id: '1',
    codigo: '1',
    nome: 'Teste',
    unidade: UnidadeEntity(
      id: '1',
      codigo: '1',
      nome: 'Teste',
      decimal: 1,
    ),
  ),
  quantidade: DoubleVO(1),
  previsaoDeEntrega: DateVO.date(DateTime.now()),
  prioridade: PrioridadeEnum.baixa,
);
