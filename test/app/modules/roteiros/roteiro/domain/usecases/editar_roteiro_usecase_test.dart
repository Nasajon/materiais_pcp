import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/roteiro_medicao_tempo_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/recurso_capacidade_dto.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/editar_roteiro_usecase.dart';

class RoteiroRepositoryMock extends Mock implements RoteiroRepository {}

void main() {
  late RoteiroRepository roteiroRepository;
  late EditarRoteiroUsecase editarRoteiroUsecase;

  setUp(() {
    roteiroRepository = RoteiroRepositoryMock();
    editarRoteiroUsecase = EditarRoteiroUsecaseImpl(roteiroRepository);
  });

  group('EditarRoteiroUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve editar um roteiro quando os dados forem valido.', () async {
        when(() => roteiroRepository.editarRoteiro(roteiro)).thenAnswer((_) async => true);

        final response = await editarRoteiroUsecase(roteiro);

        expect(response, isA<bool>());
        expect(response, true);
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro RoteiroIsNotValidFailure quando os dados não são valido.', () async {
        expect(() => editarRoteiroUsecase(RoteiroAggregate.empty()), throwsA(isA<RoteiroIsNotValidFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => roteiroRepository.editarRoteiro(roteiro)).thenThrow(RoteiroFailure());

        expect(() => editarRoteiroUsecase(roteiro), throwsA(isA<Failure>()));
      });
    });
  });
}

final roteiro = RoteiroAggregate(
  id: '1',
  codigo: CodigoVO(1),
  descricao: TextVO('Teste'),
  inicio: DateVO.date(DateTime.now()),
  fim: DateVO.date(DateTime.now()),
  produto: const ProdutoEntity(
    id: '1',
    codigo: '1',
    nome: 'Teste',
  ),
  fichaTecnica: const FichaTecnicaEntity(
    id: '1',
    codigo: '1',
    descricao: 'Teste',
  ),
  unidade: const UnidadeEntity(
    id: '1',
    codigo: '1',
    descricao: 'Teste',
    decimal: 0,
  ),
  operacoes: [
    OperacaoAggregate(
      ordem: 1,
      nome: TextVO('Teste'),
      razaoConversao: DoubleVO(1),
      preparacao: TimeVO.time(TimeOfDay.now()),
      execucao: TimeVO.time(TimeOfDay.now()),
      produtoResultante: null,
      medicaoTempo: RoteiroMedicaoTempoEnum.porLote,
      unidade: const UnidadeEntity(
        id: '1',
        codigo: '1',
        descricao: 'Teste',
        decimal: 0,
      ),
      centroDeTrabalho: const CentroDeTrabalhoEntity(
        id: '1',
        codigo: '1',
        nome: 'Teste',
      ),
      materiais: [],
      gruposDeRecurso: [
        GrupoDeRecursoAggregate(
          grupo: const GrupoDeRecursoEntity(
            id: '1',
            codigo: '1',
            nome: 'Teste',
          ),
          capacidade: capacidadeRecurso,
          recursos: [
            RecursoAggregate(
              id: '1',
              codigo: '1',
              nome: 'Teste',
              capacidade: capacidadeRecurso,
              grupoDeRestricoes: [],
            ),
          ],
        ),
      ],
    ),
  ],
);

final capacidadeRecurso = RecursoCapacidadeDTO(
  preparacao: TimeVO.time(TimeOfDay.now()),
  execucao: TimeVO.time(TimeOfDay.now()),
  capacidadeTotal: DoubleVO(1),
  minima: DoubleVO(1),
  maxima: DoubleVO(1),
);
