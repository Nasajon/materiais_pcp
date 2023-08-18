import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_grupo_de_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_grupo_de_recurso_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_grupo_de_recurso_repository_impl.dart';

class RemoteGetGrupoDeRecursoDatasourceMock extends Mock implements RemoteGetGrupoDeRecursoDatasource {}

void main() {
  late RemoteGetGrupoDeRecursoDatasource remoteGetGrupoDeRecursoDatasource;
  late GetGrupoDeRecursoRepository getGrupoDeRecursoRepository;

  setUp(() {
    remoteGetGrupoDeRecursoDatasource = RemoteGetGrupoDeRecursoDatasourceMock();
    getGrupoDeRecursoRepository = GetGrupoDeRecursoRepositoryImpl(remoteGetGrupoDeRecursoDatasource);
  });

  group('GetGrupoDeRecursoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos grupo de recurso quando informar ou não uma pesquisa.', () async {
          when(() => remoteGetGrupoDeRecursoDatasource('')).thenAnswer((_) async => <GrupoDeRecursoEntity>[]);

          final response = await getGrupoDeRecursoRepository('');

          expect(response, isA<List<GrupoDeRecursoEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RemoteRemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetGrupoDeRecursoDatasource('')).thenThrow(
            RemoteDatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getGrupoDeRecursoRepository(''), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });
      });
    });
  });
}
