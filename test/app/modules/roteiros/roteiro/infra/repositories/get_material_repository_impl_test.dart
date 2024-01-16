import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_material_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_material_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/repositories/get_material_repository_impl.dart';

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
        test('Deve retornar um RemoteRemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetMaterialDatasource('')).thenThrow(
            RemoteDatasourceRoteiroFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getMaterialRepository(''), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });
      });
    });
  });
}
