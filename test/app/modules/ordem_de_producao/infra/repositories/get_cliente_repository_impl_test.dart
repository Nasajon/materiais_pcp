import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_cliente_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_cliente_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/get_cliente_repository_impl.dart';

class RemoteGetClienteDatasourceMock extends Mock implements RemoteGetClienteDatasource {}

void main() {
  late RemoteGetClienteDatasource remoteGetClienteDatasource;
  late GetClienteRepository getClienteRepository;

  setUp(() {
    remoteGetClienteDatasource = RemoteGetClienteDatasourceMock();
    getClienteRepository = GetClienteRepositoryImpl(remoteGetClienteDatasource);
  });

  group('GetClienteRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de clientes quando informar ou não uma pesquisa.', () async {
          when(() => remoteGetClienteDatasource()).thenAnswer((_) async => <ClienteEntity>[]);

          final response = await getClienteRepository();

          expect(response, isA<List<ClienteEntity>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetClienteDatasource()).thenThrow(
            DatasourceOrdemDeProducaoFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getClienteRepository(), throwsA(isA<OrdemDeProducaoFailure>()));
        });
      });
    });
  });
}
