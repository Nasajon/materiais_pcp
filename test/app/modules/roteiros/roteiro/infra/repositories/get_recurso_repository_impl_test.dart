import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_recurso_repository_impl.dart';

class RemoteGetRecursoDatasourceMock extends Mock implements RemoteGetRecursoDatasource {}

void main() {
  late RemoteGetRecursoDatasource remoteGetRecursoDatasource;
  late GetRecursoRepository getRecursoRepository;

  setUp(() {
    remoteGetRecursoDatasource = RemoteGetRecursoDatasourceMock();
    getRecursoRepository = GetRecursoRepositoryImpl(remoteGetRecursoDatasource);
  });

  group('GetRecursoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos recursos quando informar o id do grupo de recurso.', () async {
          when(() => remoteGetRecursoDatasource('1')).thenAnswer((_) async => <RecursoAggregate>[]);

          final response = await getRecursoRepository('1');

          expect(response, isA<List<RecursoAggregate>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no datasource.', () async {
          when(() => remoteGetRecursoDatasource('')).thenThrow(
            DatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getRecursoRepository(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}
