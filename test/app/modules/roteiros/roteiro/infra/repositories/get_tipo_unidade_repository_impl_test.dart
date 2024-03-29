import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_unidade_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_unidade_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_tipo_unidade_repository_impl.dart';

class RemoteGetUnidadeDatasourceMock extends Mock implements RemoteGetUnidadeDatasource {}

void main() {
  late RemoteGetUnidadeDatasource remoteGetUnidadeDatasource;
  late GetUnidadeRepository getUnidadeRepository;

  setUp(() {
    remoteGetUnidadeDatasource = RemoteGetUnidadeDatasourceMock();
    getUnidadeRepository = GetUnidadeRepositoryImpl(remoteGetUnidadeDatasource);
  });

  group('GetUnidadeRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos tipos de unidades quando informar ou não uma pesquisa.', () async {
          when(() => remoteGetUnidadeDatasource('')).thenAnswer((_) async => <UnidadeEntity>[]);

          final response = await getUnidadeRepository('');

          expect(response, isA<List<UnidadeEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RemoteRemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetUnidadeDatasource('')).thenThrow(
            RemoteDatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getUnidadeRepository(''), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });
      });
    });
  });
}
