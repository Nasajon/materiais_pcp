import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_operacao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_operacao_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/get_operacao_repository_impl.dart';

class RemoteGetOperacaoDatasourceMock extends Mock implements RemoteGetOperacaoDatasource {}

void main() {
  late RemoteGetOperacaoDatasource remoteGetOperacaoDatasource;
  late GetOperacaoRepository getOperacaoRepository;

  setUp(() {
    remoteGetOperacaoDatasource = RemoteGetOperacaoDatasourceMock();
    getOperacaoRepository = GetOperacaoRepositoryImpl(remoteGetOperacaoDatasource);
  });

  group('GetOperacaoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('Deve retornar uma lista de operações quando informar o codigo do roteiro.', () async {
          when(() => remoteGetOperacaoDatasource(['1'])).thenAnswer((_) async => <OperacaoAggregate>[]);

          final response = await getOperacaoRepository(['1']);

          expect(response, isA<List<OperacaoAggregate>>());
        });
      });

      group('falha -', () {
        test('Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteGetOperacaoDatasource([])).thenThrow(
            DatasourceOrdemDeProducaoFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => getOperacaoRepository([]), throwsA(isA<OrdemDeProducaoFailure>()));
        });
      });
    });
  });
}
