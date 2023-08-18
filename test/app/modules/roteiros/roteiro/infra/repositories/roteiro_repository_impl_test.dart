import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_roteiro_datasource.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/roteiro_repository_impl.dart';

class RemoteRoteiroDatasourceMock extends Mock implements RemoteRoteiroDatasource {}

void main() {
  late RemoteRoteiroDatasource remoteRoteiroDatasource;
  late RoteiroRepository roteiroRepository;

  setUp(() {
    remoteRoteiroDatasource = RemoteRoteiroDatasourceMock();
    roteiroRepository = RoteiroRepositoryImpl(remoteRoteiroDatasource);
  });

  group('RoteiroRepositoryImpl -', () {
    group('remote -', () {
      group('sucesso -', () {
        test('getRoteiroRecente - Deve retornar uma lista de roteiros recentes quando o a conexão for remota.', () async {
          when(() => remoteRoteiroDatasource.getRoteiroRecente()).thenAnswer((invocation) async => <RoteiroEntity>[]);

          final response = await roteiroRepository.getRoteiroRecente();

          expect(response, isA<List<RoteiroEntity>>());
        });

        test('getRoteiro - Deve retornar uma lista de roteiros recentes quando passar ou não uma pesquisa.', () async {
          when(() => remoteRoteiroDatasource.getRoteiro('')).thenAnswer((invocation) async => <RoteiroEntity>[]);

          final response = await roteiroRepository.getRoteiro('');

          expect(response, isA<List<RoteiroEntity>>());
        });

        test('getRoteiroPeloId - Deve retornar um RoteiroAggregate quando passar o id do roteiro.', () async {
          when(() => remoteRoteiroDatasource.getRoteiroPeloId('1')).thenAnswer((invocation) async => RoteiroAggregate.empty());

          final response = await roteiroRepository.getRoteiroPorId('1');

          expect(response, isA<RoteiroAggregate>());
        });

        test('inserirRoteiro - Deve inserir o roteiro e retornar o id quando passar os dados do roteiro corretos.', () async {
          when(() => remoteRoteiroDatasource.inserirRoteiro(RoteiroAggregate.empty())).thenAnswer((invocation) async => '1');

          final response = await roteiroRepository.inserirRoteiro(RoteiroAggregate.empty());

          expect(response, isA<String>());
          expect(response, '1');
        });

        test('editarRoteiro - Deve editar o roteiro e retornar true quando passar os dados do roteiro corretos.', () async {
          when(() => remoteRoteiroDatasource.editarRoteiro(RoteiroAggregate.empty())).thenAnswer((invocation) async => true);

          final response = await roteiroRepository.editarRoteiro(RoteiroAggregate.empty());

          expect(response, isA<bool>());
          expect(response, true);
        });

        test('deletarRoteiro - Deve deletar o roteiro e retornar true quando passar o id do roteiro.', () async {
          when(() => remoteRoteiroDatasource.deletarRoteiro('1')).thenAnswer((invocation) async => true);

          final response = await roteiroRepository.deletarRoteiro('1');

          expect(response, isA<bool>());
          expect(response, true);
        });
      });

      group('falha -', () {
        test('getRoteiroRecente - Deve retornar um RemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteRoteiroDatasource.getRoteiroRecente())
              .thenThrow(RemoteDatasourceRoteiroFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => roteiroRepository.getRoteiroRecente(), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });

        test('getRoteiro - Deve retornar um RemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteRoteiroDatasource.getRoteiro(''))
              .thenThrow(RemoteDatasourceRoteiroFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => roteiroRepository.getRoteiro(''), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });

        test('getRoteiroPeloId - Deve retornar um RemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteRoteiroDatasource.getRoteiroPeloId(''))
              .thenThrow(RemoteDatasourceRoteiroFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => roteiroRepository.getRoteiroPorId(''), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });

        test('inserirRoteiro - Deve retornar um RemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteRoteiroDatasource.inserirRoteiro(RoteiroAggregate.empty()))
              .thenThrow(RemoteDatasourceRoteiroFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => roteiroRepository.inserirRoteiro(RoteiroAggregate.empty()), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });

        test('editarRoteiro - Deve retornar um RemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteRoteiroDatasource.editarRoteiro(RoteiroAggregate.empty()))
              .thenThrow(RemoteDatasourceRoteiroFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => roteiroRepository.editarRoteiro(RoteiroAggregate.empty()), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });

        test('deletarRoteiro - Deve retornar um RemoteDatasourceRoteiroFailure quando ocorrer erro mapeado no Datasource.', () async {
          when(() => remoteRoteiroDatasource.deletarRoteiro('1'))
              .thenThrow(RemoteDatasourceRoteiroFailure(errorMessage: '', stackTrace: StackTrace.current));

          expect(() => roteiroRepository.deletarRoteiro('1'), throwsA(isA<RemoteDatasourceRoteiroFailure>()));
        });
      });
    });
  });
}
