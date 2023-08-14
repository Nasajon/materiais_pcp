import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_restricao_by_grupo_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_restricao_by_grupo_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_restricao_by_grupo_repository_impl.dart';

class RemoteGetRestricaoByGrupoDatasourceMock extends Mock implements RemoteGetRestricaoByGrupoDatasource {}

void main() {
  late RemoteGetRestricaoByGrupoDatasource remoteGetRestricaoByGrupoDatasource;
  late GetRestricaoByGrupoRepository getRestricaoByGrupoRepository;

  setUp(() {
    remoteGetRestricaoByGrupoDatasource = RemoteGetRestricaoByGrupoDatasourceMock();
    getRestricaoByGrupoRepository = GetRestricaoByGrupoRepositoryImpl(remoteGetRestricaoByGrupoDatasource);
  });

  group('GetRestricaoByGrupoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista das restrições quando informar o id do grupo de restrição.', () async {
          when(() => remoteGetRestricaoByGrupoDatasource('1')).thenAnswer((_) async => <RestricaoEntity>[]);

          final response = await getRestricaoByGrupoRepository('1');

          expect(response, isA<List<RestricaoEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no datasource.', () async {
          when(() => remoteGetRestricaoByGrupoDatasource('')).thenThrow(
            DatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getRestricaoByGrupoRepository(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}
