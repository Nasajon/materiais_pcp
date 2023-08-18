import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_restricao_por_grupo_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_restricao_por_grupo_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_restricao_por_grupo_repository_impl.dart';

class RemoteGetRestricaoPorGrupoDatasourceMock extends Mock implements RemoteGetRestricaoPorGrupoDatasource {}

void main() {
  late RemoteGetRestricaoPorGrupoDatasource remoteGetRestricaoPorGrupoDatasource;
  late GetRestricaoPorGrupoRepository getRestricaoPorGrupoRepository;

  setUp(() {
    remoteGetRestricaoPorGrupoDatasource = RemoteGetRestricaoPorGrupoDatasourceMock();
    getRestricaoPorGrupoRepository = GetRestricaoPorGrupoRepositoryImpl(remoteGetRestricaoPorGrupoDatasource);
  });

  group('GetRestricaoPorGrupoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista das restrições quando informar o id do grupo de restrição.', () async {
          when(() => remoteGetRestricaoPorGrupoDatasource('1')).thenAnswer((_) async => <RestricaoAggregate>[]);

          final response = await getRestricaoPorGrupoRepository('1');

          expect(response, isA<List<RestricaoAggregate>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetRestricaoPorGrupoDatasource('')).thenThrow(
            RemoteDatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getRestricaoPorGrupoRepository(''), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });
      });
    });
  });
}
