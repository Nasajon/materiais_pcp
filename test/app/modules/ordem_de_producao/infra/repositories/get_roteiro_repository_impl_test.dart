import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_roteiro_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/get_roteiro_repository_impl.dart';

class RemoteGetRoteiroDatasourceMock extends Mock implements RemoteGetRoteiroDatasource {}

void main() {
  late RemoteGetRoteiroDatasource remoteGetRoteiroDatasource;
  late GetRoteiroRepository getRoteiroRepository;

  setUp(() {
    remoteGetRoteiroDatasource = RemoteGetRoteiroDatasourceMock();
    getRoteiroRepository = GetRoteiroRepositoryImpl(remoteGetRoteiroDatasource);
  });

  group('GetRoteiroRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de roteiros quando informar ou não uma pesquisa.', () async {
          when(() => remoteGetRoteiroDatasource('1')).thenAnswer((_) async => <RoteiroEntity>[]);

          final response = await getRoteiroRepository('1');

          expect(response, isA<List<RoteiroEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetRoteiroDatasource('1')).thenThrow(
            DatasourceOrdemDeProducaoFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getRoteiroRepository('1'), throwsA(isA<OrdemDeProducaoFailure>()));
        });
      });
    });
  });
}
