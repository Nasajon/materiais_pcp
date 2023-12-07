import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/dto/sequenciamento_dto.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/sequenciamento_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_sequenciamento_datasource.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/repositories/sequenciamento_repository_impl.dart';

class RemoteSequenciamentoDatasourceMock extends Mock implements RemoteSequenciamentoDatasource {}

void main() {
  late RemoteSequenciamentoDatasource remoteSequenciamentoDatasource;
  late SequenciamentoRepository sequenciamentoRepository;

  setUp(() {
    remoteSequenciamentoDatasource = RemoteSequenciamentoDatasourceMock();
    sequenciamentoRepository = SequenciamentoRepositoryImpl(remoteSequenciamentoDatasource);
  });

  group('SequenciamentoRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('gerarSequencimaneto - Deve retornar um sequenciamento da ordem de produção quando informar as ordens e os recurso.',
            () async {
          const sequenciamento = SequenciamentoDTO(
            ordensIds: [],
            recursosIds: [],
            restricoesIds: [],
          );

          when(() => remoteSequenciamentoDatasource.gerarSequencimaneto(sequenciamento))
              .thenAnswer((_) async => SequenciamentoAggregate.empty());

          final response = await sequenciamentoRepository.gerarSequencimaneto(sequenciamento);

          expect(response, isA<SequenciamentoAggregate>());
        });

        test('sequenciarOrdemDeProducao - Deve retornar true quando confirma o sequenciamento passando os dados gerado pelo backend.',
            () async {
          when(() => remoteSequenciamentoDatasource.sequenciarOrdemDeProducao(SequenciamentoAggregate.empty()))
              .thenAnswer((_) async => true);

          final response = await sequenciamentoRepository.sequenciarOrdemDeProducao(SequenciamentoAggregate.empty());

          expect(response, isA<bool>());
        });
      });

      group('falha -', () {
        test('gerarSequencimaneto - Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          const sequenciamento = SequenciamentoDTO(
            ordensIds: [],
            recursosIds: [],
            restricoesIds: [],
          );

          when(() => remoteSequenciamentoDatasource.gerarSequencimaneto(sequenciamento)).thenThrow(
            DatasourceOrdemDeProducaoFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => sequenciamentoRepository.gerarSequencimaneto(sequenciamento), throwsA(isA<OrdemDeProducaoFailure>()));
        });
        test('Deve retornar um OrdemDeProducaoFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteSequenciamentoDatasource.sequenciarOrdemDeProducao(SequenciamentoAggregate.empty())).thenThrow(
            DatasourceOrdemDeProducaoFailure(errorMessage: 'error', stackTrace: StackTrace.current),
          );

          expect(() => sequenciamentoRepository.sequenciarOrdemDeProducao(SequenciamentoAggregate.empty()),
              throwsA(isA<OrdemDeProducaoFailure>()));
        });
      });
    });
  });
}
