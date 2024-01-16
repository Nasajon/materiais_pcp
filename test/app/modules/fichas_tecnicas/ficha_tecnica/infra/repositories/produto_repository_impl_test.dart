import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/produto_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/produto_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/datasources/remotes/remote_produto_datasource%20copy.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/repositories/produto_repository_impl.dart';

class RemoteProdutoDatasourceMock extends Mock implements RemoteProdutoDatasource {}

void main() {
  late RemoteProdutoDatasource remoteProdutoDatasource;
  late ProdutoRepository produtoRepository;

  setUp(() {
    remoteProdutoDatasource = RemoteProdutoDatasourceMock();
    produtoRepository = ProdutoRepositoryImpl(remoteProdutoDatasource);
  });

  group('ProdutoRepository -', () {
    group('getTodosProdutos -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de produtos quando informar ou não uma pesquisa.', () async {
          when(() => remoteProdutoDatasource.getTodosProdutos('')).thenAnswer((_) async => <ProdutoEntity>[]);

          final response = await produtoRepository.getTodosProdutos('');

          expect(response, isA<List<ProdutoEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceProdutoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteProdutoDatasource.getTodosProdutos('')).thenThrow(
            DatasourceProdutoFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => produtoRepository.getTodosProdutos(''), throwsA(isA<DatasourceProdutoFailure>()));
        });
      });
    });
    group('getTodosProdutosPorIds -', () {
      group('sucesso -', () {
        test('Deve retornar um mapa de produtos quando informar uma lista de ids.', () async {
          when(() => remoteProdutoDatasource.getTodosProdutosPorIds([''])).thenAnswer((_) async => <String, ProdutoEntity>{});

          final response = await produtoRepository.getTodosProdutosPorIds(['']);

          expect(response, isA<Map<String, ProdutoEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceProdutoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteProdutoDatasource.getTodosProdutosPorIds([''])).thenThrow(
            DatasourceProdutoFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => produtoRepository.getTodosProdutosPorIds(['']), throwsA(isA<DatasourceProdutoFailure>()));
        });
      });
    });
  });
}
