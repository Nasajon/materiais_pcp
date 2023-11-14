import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_ficha_tecnica_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_ficha_tecnica_repository_impl.dart';

class RemoteGetFichaTecnicaDatasourceMock extends Mock implements RemoteGetFichaTecnicaDatasource {}

void main() {
  late RemoteGetFichaTecnicaDatasource remoteGetFichaTecnicaDatasource;
  late GetFichaTecnicaRepository getFichaTecnicaRepository;

  setUp(() {
    remoteGetFichaTecnicaDatasource = RemoteGetFichaTecnicaDatasourceMock();
    getFichaTecnicaRepository = GetFichaTecnicaRepositoryImpl(remoteGetFichaTecnicaDatasource);
  });

  group('GetFichaTecnicaRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de ficha tecnica quando informar ou não uma pesquisa.', () async {
          when(() => remoteGetFichaTecnicaDatasource('')).thenAnswer((_) async => <FichaTecnicaEntity>[]);

          final response = await getFichaTecnicaRepository('');

          expect(response, isA<List<FichaTecnicaEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RemoteRemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetFichaTecnicaDatasource('')).thenThrow(
            RemoteDatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getFichaTecnicaRepository(''), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });
      });
    });
  });
}
