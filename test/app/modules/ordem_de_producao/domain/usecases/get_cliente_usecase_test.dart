import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_cliente_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_cliente_usecase.dart';

class GetClienteRepositoryMock extends Mock implements GetClienteRepository {}

void main() {
  late GetClienteRepository getClienteRepository;
  late GetClienteUsecase getClienteUsecase;

  setUp(() {
    getClienteRepository = GetClienteRepositoryMock();
    getClienteUsecase = GetClienteUsecaseImpl(getClienteRepository);
  });

  group('GetClienteUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de clientes quando passar ou não uma pesquisa.', () async {
        when(() => getClienteRepository(search: '')).thenAnswer((_) async => <ClienteEntity>[]);

        final response = await getClienteUsecase(search: '');

        expect(response, isA<List<ClienteEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => getClienteRepository(search: '')).thenThrow(OrdemDeProducaoFailure(errorMessage: ''));

        expect(() => getClienteUsecase(search: ''), throwsA(isA<OrdemDeProducaoFailure>()));
      });
    });
  });
}
