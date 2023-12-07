import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/aprovar_ordem_de_producao_usecase.dart';

class OrdemDeProducaoRepositoryMock extends Mock implements OrdemDeProducaoRepository {}

void main() {
  late OrdemDeProducaoRepository ordemDeProducaoRepository;
  late AprovarOrdemDeProducaoUsecase aprovarOrdemDeProducaoUsecase;

  setUp(() {
    ordemDeProducaoRepository = OrdemDeProducaoRepositoryMock();
    aprovarOrdemDeProducaoUsecase = AprovarOrdemDeProducaoUsecaseImpl(ordemDeProducaoRepository: ordemDeProducaoRepository);
  });

  group('AprovarOrdemDeProducaoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve aprovar uma ordem de producao quando passar informar o id para o backend.', () async {
        when(() => ordemDeProducaoRepository.aprovarOrdemDeProducao('1')).thenAnswer((_) async => true);

        final response = await aprovarOrdemDeProducaoUsecase('1');

        expect(response, isA<bool>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro OrdemDeProducaoFailure quando não informar o id do ordemDeProducao.', () async {
        expect(() => aprovarOrdemDeProducaoUsecase(''), throwsA(isA<IdNotFoundOrdemDeProducaoFailure>()));
      });

      test('Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no repository.', () async {
        when(() => ordemDeProducaoRepository.aprovarOrdemDeProducao('')).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => aprovarOrdemDeProducaoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
