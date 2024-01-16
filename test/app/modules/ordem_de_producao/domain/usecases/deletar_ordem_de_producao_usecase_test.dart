import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/deletar_ordem_de_producao_usecase.dart';

class OrdemDeProducaoRepositoryMock extends Mock implements OrdemDeProducaoRepository {}

void main() {
  late OrdemDeProducaoRepository ordemDeProducaoRepository;
  late DeletarOrdemDeProducaoUsecase deletarOrdemDeProducaoUsecase;

  setUp(() {
    ordemDeProducaoRepository = OrdemDeProducaoRepositoryMock();
    deletarOrdemDeProducaoUsecase = DeletarOrdemDeProducaoUsecaseImpl(ordemDeProducaoRepository: ordemDeProducaoRepository);
  });

  group('DeletarOrdemDeProducaoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve deletar uma ordem de producao quando passar informar o id para o backend.', () async {
        when(() => ordemDeProducaoRepository.deletar('1')).thenAnswer((_) async => true);

        final response = await deletarOrdemDeProducaoUsecase('1');

        expect(response, isA<bool>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro OrdemDeProducaoFailure quando não informar o id do ordemDeProducao.', () async {
        expect(() => deletarOrdemDeProducaoUsecase(''), throwsA(isA<IdNotFoundOrdemDeProducaoFailure>()));
      });

      test('Deve retornar um OrdemDeProducaoFailure quando ocorrer um erro no repository.', () async {
        when(() => ordemDeProducaoRepository.deletar('')).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => deletarOrdemDeProducaoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
