import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/tipo_unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_tipo_unidade_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_tipo_unidade_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_tipo_unidade_repository_impl.dart';

class RemoteGetTipoUnidadeDatasourceMock extends Mock implements RemoteGetTipoUnidadeDatasource {}

void main() {
  late RemoteGetTipoUnidadeDatasource remoteGetTipoUnidadeDatasource;
  late GetTipoUnidadeRepository getTipoUnidadeRepository;

  setUp(() {
    remoteGetTipoUnidadeDatasource = RemoteGetTipoUnidadeDatasourceMock();
    getTipoUnidadeRepository = GetTipoUnidadeRepositoryImpl(remoteGetTipoUnidadeDatasource);
  });

  group('GetTipoUnidadeRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos tipos de unidades quando informar ou não uma pesquisa.', () async {
          when(() => remoteGetTipoUnidadeDatasource('')).thenAnswer((_) async => <TipoUnidadeEntity>[]);

          final response = await getTipoUnidadeRepository('');

          expect(response, isA<List<TipoUnidadeEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no datasource.', () async {
          when(() => remoteGetTipoUnidadeDatasource('')).thenThrow(
            DatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getTipoUnidadeRepository(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}
