import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/repositories/get_turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/infra/repositories/get_turno_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/infra/datasources/remotes/remote_get_turno_trabalho_datasource.dart';

class RemoteGetTurnoTrabalhoDatasourceMock extends Mock implements RemoteGetTurnoTrabalhoDatasource {}

void main() {
  late RemoteGetTurnoTrabalhoDatasource remoteGetTurnoTrabalhoDatasource;
  late GetTurnoTrabalhoRepository getTurnoTrabalhoRepository;

  setUp(() {
    remoteGetTurnoTrabalhoDatasource = RemoteGetTurnoTrabalhoDatasourceMock();
    getTurnoTrabalhoRepository = GetTurnoTrabalhoRepositoryImpl(remoteGetTurnoTrabalhoDatasource);
  });

  group('GetTurnoTrabalhoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista dos turnos de trabalho.', () async {
          when(() => remoteGetTurnoTrabalhoDatasource()).thenAnswer((_) async => <TurnoTrabalhoEntity>[]);

          final response = await getTurnoTrabalhoRepository();

          expect(response, isA<List<TurnoTrabalhoEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um DatasourceCentroTrabalhoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetTurnoTrabalhoDatasource()).thenThrow(
            DatasourceCentroTrabalhoFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getTurnoTrabalhoRepository(), throwsA(isA<DatasourceCentroTrabalhoFailure>()));
        });
      });
    });
  });
}
