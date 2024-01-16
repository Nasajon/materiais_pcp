import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/produto_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/produto_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_produtos_por_ids_usecase.dart';

class ProdutoRepositoryMock extends Mock implements ProdutoRepository {}

void main() {
  late ProdutoRepository produtoRepository;
  late GetProdutosPorIdsUsecase getProdutoPorIdsUsecase;

  setUp(() {
    produtoRepository = ProdutoRepositoryMock();
    getProdutoPorIdsUsecase = GetProdutosPorIdsUsecaseImpl(produtoRepository);
  });

  group('GetProdutoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de produto quando passar ou não uma pesquisa.', () async {
        when(() => produtoRepository.getTodosProdutosPorIds([''])).thenAnswer((_) async => <String, ProdutoEntity>{});

        final response = await getProdutoPorIdsUsecase(['']);

        expect(response, isA<Map<String, ProdutoEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => produtoRepository.getTodosProdutosPorIds([''])).thenThrow(ProdutoFailure());

        expect(() => getProdutoPorIdsUsecase(['']), throwsA(isA<ProdutoFailure>()));
      });
    });
  });
}
