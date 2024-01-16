import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_recurso_por_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_recurso_por_grupo_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_recurso_por_grupo_repository_impl.dart';

class RemoteGetRecursoPorGrupoDatasourceMock extends Mock implements RemoteGetRecursoPorGrupoDatasource {}

void main() {
  late RemoteGetRecursoPorGrupoDatasource remoteGetRecursoPorGrupoDatasource;
  late GetRecursoPorGrupoRepository getRecursoRepository;

  setUp(() {
    remoteGetRecursoPorGrupoDatasource = RemoteGetRecursoPorGrupoDatasourceMock();
    getRecursoRepository = GetRecursoPorGrupoRepositoryImpl(remoteGetRecursoPorGrupoDatasource);
  });

  group('GetRecursoPorGrupoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos recursos quando informar o id do grupo de recurso.', () async {
          when(() => remoteGetRecursoPorGrupoDatasource('1')).thenAnswer((_) async => <RecursoAggregate>[]);

          final response = await getRecursoRepository('1');

          expect(response, isA<List<RecursoAggregate>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetRecursoPorGrupoDatasource('')).thenThrow(
            RemoteDatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getRecursoRepository(''), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });
      });
    });
  });
}
