import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_produto_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_produto_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_produto_repository_impl.dart';

class RemoteGetProdutoDatasourceMock extends Mock implements RemoteGetProdutoDatasource {}

void main() {
  late RemoteGetProdutoDatasource remoteGetProdutoDatasource;
  late GetProdutoRepository getProdutoRepository;

  setUp(() {
    remoteGetProdutoDatasource = RemoteGetProdutoDatasourceMock();
    getProdutoRepository = GetProdutoRepositoryImpl(remoteGetProdutoDatasource);
  });

  group('GetProdutoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos grupo de recurso quando informar ou não uma pesquisa.', () async {
          when(() => remoteGetProdutoDatasource('')).thenAnswer((_) async => <ProdutoEntity>[]);

          final response = await getProdutoRepository('');

          expect(response, isA<List<ProdutoEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RemoteRemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetProdutoDatasource('')).thenThrow(
            RemoteDatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getProdutoRepository(''), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });
      });
    });
  });
}
