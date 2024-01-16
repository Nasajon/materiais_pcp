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
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/status_ordem_de_producao_enum.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/inserir_ordem_de_producao_usecase.dart';

class OrdemDeProducaoRepositoryMock extends Mock implements OrdemDeProducaoRepository {}

void main() {
  late OrdemDeProducaoRepository ordemDeProducaoRepository;
  late InserirOrdemDeProducaoUsecase inserirOrdemDeProducaoUsecase;

  setUp(() {
    ordemDeProducaoRepository = OrdemDeProducaoRepositoryMock();
    inserirOrdemDeProducaoUsecase = InserirOrdemDeProducaoUsecaseImpl(ordemDeProducaoRepository: ordemDeProducaoRepository);
  });

  group('InserirOrdemDeProducaoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve inserir um ordemDeProducao quando os dados forem valido.', () async {
        when(() => ordemDeProducaoRepository.inserir(ordemDeProducao)).thenAnswer((_) async => ordemDeProducao);

        final response = await inserirOrdemDeProducaoUsecase(ordemDeProducao);

        expect(response, isA<OrdemDeProducaoAggregate>());
        expect(response.id, '1');
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro OrdemDeProducaoIsNotValidFailure quando os dados não são valido.', () async {
        expect(() => inserirOrdemDeProducaoUsecase(OrdemDeProducaoAggregate.empty()), throwsA(isA<InvalidOrdemDeProducaoFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => ordemDeProducaoRepository.inserir(ordemDeProducao)).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => inserirOrdemDeProducaoUsecase(ordemDeProducao), throwsA(isA<OrdemDeProducaoFailure>()));
      });
    });
  });
}

final ordemDeProducao = OrdemDeProducaoAggregate(
  id: '1',
  codigo: CodigoVO(1),
  status: StatusOrdemDeProducaoEnum.aberta,
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
