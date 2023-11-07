import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_produto_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_produto_usecase.dart';

class GetProdutoRepositoryMock extends Mock implements GetProdutoRepository {}

void main() {
  late GetProdutoRepository getProdutoRepository;
  late GetProdutoUsecase getProdutoUsecase;

  setUp(() {
    getProdutoRepository = GetProdutoRepositoryMock();
    getProdutoUsecase = GetProdutoUsecaseImpl(getProdutoRepository);
  });

  group('GetProdutoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de produto quando passar ou não uma pesquisa.', () async {
        when(() => getProdutoRepository(search: '')).thenAnswer((_) async => <ProdutoEntity>[]);

        final response = await getProdutoUsecase(search: '');

        expect(response, isA<List<ProdutoEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => getProdutoRepository(search: '')).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => getProdutoUsecase(search: ''), throwsA(isA<OrdemDeProducaoFailure>()));
      });
    });
  });
}
