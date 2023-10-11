import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/produto_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/produto_repository.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/usecases/get_todos_produtos_usecase.dart';

class ProdutoRepositoryMock extends Mock implements ProdutoRepository {}

void main() {
  late ProdutoRepository produtoRepository;
  late GetTodosProdutosUsecase getTodosProdutosUsecase;

  setUp(() {
    produtoRepository = ProdutoRepositoryMock();
    getTodosProdutosUsecase = GetTodosProdutosUsecaseImpl(produtoRepository);
  });

  group('GetUnidadeUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista dos tipos de unidades quando passar ou não uma pesquisa.', () async {
        when(() => produtoRepository.getTodosProdutos('')).thenAnswer((_) async => <ProdutoEntity>[]);

        final response = await getTodosProdutosUsecase('');

        expect(response, isA<List<ProdutoEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => produtoRepository.getTodosProdutos('')).thenThrow(ProdutoFailure());

        expect(() => getTodosProdutosUsecase(''), throwsA(isA<ProdutoFailure>()));
      });
    });
  });
}
