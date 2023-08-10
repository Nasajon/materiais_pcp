import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_centro_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_centro_de_trabalho_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_centro_de_trabalho_repository_impl.dart';

class RemoteGetCentroDeTrabalhoDatasourceMock extends Mock implements RemoteGetCentroDeTrabalhoDatasource {}

void main() {
  late RemoteGetCentroDeTrabalhoDatasource remoteGetCentroDeTrabalhoDatasource;
  late GetCentroDeTrabalhoRepository getCentroDeTrabalhoRepository;

  setUp(() {
    remoteGetCentroDeTrabalhoDatasource = RemoteGetCentroDeTrabalhoDatasourceMock();
    getCentroDeTrabalhoRepository = GetCentroDeTrabalhoRepositoryImpl(remoteGetCentroDeTrabalhoDatasource);
  });

  group('GetCentroDeTrablhoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de centro de trabalho quando informar ou não uma pesquisa.', () async {
          when(() => remoteGetCentroDeTrabalhoDatasource('')).thenAnswer((_) async => <CentroDeTrabalhoEntity>[]);

          final response = await getCentroDeTrabalhoRepository('');

          expect(response, isA<List<CentroDeTrabalhoEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no datasource.', () async {
          when(() => remoteGetCentroDeTrabalhoDatasource('')).thenThrow(
            DatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getCentroDeTrabalhoRepository(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}
