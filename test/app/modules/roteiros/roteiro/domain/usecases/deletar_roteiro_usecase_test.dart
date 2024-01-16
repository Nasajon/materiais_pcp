import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/roteiro_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/deletar_roteiro_usecase.dart';

class RoteiroRepositoryMock extends Mock implements RoteiroRepository {}

void main() {
  late RoteiroRepository roteiroRepository;
  late DeletarRoteiroUsecase deletarRoteiroUsecase;

  setUp(() {
    roteiroRepository = RoteiroRepositoryMock();
    deletarRoteiroUsecase = DeletarRoteiroUsecaseImpl(roteiroRepository);
  });

  group('DeletarRoteiroUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve deletar um roteiro quando passar informar o id para o backend.', () async {
        when(() => roteiroRepository.deletarRoteiro('1')).thenAnswer((_) async => true);

        final response = await deletarRoteiroUsecase('1');

        expect(response, isA<bool>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundRoteiroFailure quando não informar o id do roteiro.', () async {
        expect(() => deletarRoteiroUsecase(''), throwsA(isA<IdNotFoundRoteiroFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => roteiroRepository.deletarRoteiro('')).thenThrow(RoteiroFailure());

        expect(() => deletarRoteiroUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
