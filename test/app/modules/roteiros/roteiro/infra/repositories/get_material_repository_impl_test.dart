import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_material_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_material_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_material_repository_impl.dart';

class RemoteGetMaterialDatasourceMock extends Mock implements RemoteGetMaterialDatasource {}

void main() {
  late RemoteGetMaterialDatasource remoteGetMaterialDatasource;
  late GetMaterialRepository getMaterialRepository;

  setUp(() {
    remoteGetMaterialDatasource = RemoteGetMaterialDatasourceMock();
    getMaterialRepository = GetMaterialRepositoryImpl(remoteGetMaterialDatasource);
  });

  group('GetMaterialRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de materiais quando passar o id da ficha tecnica.', () async {
          when(() => remoteGetMaterialDatasource('1')).thenAnswer((_) async => <MaterialEntity>[]);

          final response = await getMaterialRepository('1');

          expect(response, isA<List<MaterialEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um RoteiroFailure quando ocorrer um erro no datasource.', () async {
          when(() => remoteGetMaterialDatasource('')).thenThrow(
            DatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getMaterialRepository(''), throwsA(isA<RoteiroFailure>()));
        });
      });
    });
  });
}
