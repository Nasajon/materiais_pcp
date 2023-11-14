import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_produto_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_produto_usecase.dart';

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
        when(() => getProdutoRepository('')).thenAnswer((_) async => <ProdutoEntity>[]);

        final response = await getProdutoUsecase('');

        expect(response, isA<List<ProdutoEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => getProdutoRepository('')).thenThrow(RoteiroFailure());

        expect(() => getProdutoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
