import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/deletar_centro_trabalho_usecase.dart';

class CentroTrabalhoRepositoryMock extends Mock implements CentroTrabalhoRepository {}

void main() {
  late CentroTrabalhoRepository centroTrabalhoRepository;
  late DeletarCentroTrabalhoUsecase deletarCentroTrabalhoUsecase;

  setUp(() {
    centroTrabalhoRepository = CentroTrabalhoRepositoryMock();
    deletarCentroTrabalhoUsecase = DeletarCentroTrabalhoUsecaseImpl(centroTrabalhoRepository);
  });

  group('DeletarCentroTrabalhoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve deletar um centro de trabalho quando passar informar o id para o backend.', () async {
        when(() => centroTrabalhoRepository.deletarCentroTrabalho('1')).thenAnswer((_) async => true);

        final response = await deletarCentroTrabalhoUsecase('1');

        expect(response, isA<bool>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundCentroTrabalhoFailure quando não informar o id do centro de trabalho.', () async {
        expect(() => deletarCentroTrabalhoUsecase(''), throwsA(isA<IdNotFoundCentroTrabalhoFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => centroTrabalhoRepository.deletarCentroTrabalho('')).thenThrow(CentroTrabalhoFailure());

        expect(() => deletarCentroTrabalhoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
