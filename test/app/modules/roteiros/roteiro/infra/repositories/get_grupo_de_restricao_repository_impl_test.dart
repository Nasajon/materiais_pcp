import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_grupo_de_restricao_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_grupo_de_restricao_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_grupo_de_restricao_repository_impl.dart';

class RemoteGetGrupoDeRestricaoDatasourceMock extends Mock implements RemoteGetGrupoDeRestricaoDatasource {}

void main() {
  late RemoteGetGrupoDeRestricaoDatasource remoteGetGrupoDeRestricaoDatasource;
  late GetGrupoDeRestricaoRepository getGrupoDeRestricaoRepository;

  setUp(() {
    remoteGetGrupoDeRestricaoDatasource = RemoteGetGrupoDeRestricaoDatasourceMock();
    getGrupoDeRestricaoRepository = GetGrupoDeRestricaoRepositoryImpl(remoteGetGrupoDeRestricaoDatasource);
  });

  group('GetGrupoDeRestricaoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos grupo de restrições quando informar ou não uma pesquisa.', () async {
          when(() => remoteGetGrupoDeRestricaoDatasource('')).thenAnswer((_) async => <GrupoDeRestricaoEntity>[]);

          final response = await getGrupoDeRestricaoRepository('');

          expect(response, isA<List<GrupoDeRestricaoEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RemoteRemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetGrupoDeRestricaoDatasource('')).thenThrow(
            RemoteDatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getGrupoDeRestricaoRepository(''), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });
      });
    });
  });
}
