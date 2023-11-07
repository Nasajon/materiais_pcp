import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/usecases/deletar_ficha_tecnica_usecase.dart';

class FichaTecnicaRepositoryMock extends Mock implements FichaTecnicaRepository {}

void main() {
  late FichaTecnicaRepository fichaTecnicaRepository;
  late DeletarFichaTecnicaUsecase deletarFichaTecnicaUsecase;

  setUp(() {
    fichaTecnicaRepository = FichaTecnicaRepositoryMock();
    deletarFichaTecnicaUsecase = DeletarFichaTecnicaUsecaseImpl(fichaTecnicaRepository);
  });

  group('GetRestricaoByGrupoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve deletar uma ficha técnica quando passar informar o id ', () async {
        when(() => fichaTecnicaRepository.deletarFichaTecnica('1')).thenAnswer((_) async => true);

        final response = await deletarFichaTecnicaUsecase('1');

        expect(response, isA<bool>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundRoteiroFailure quando não informar o id da ficha técnica.', () async {
        expect(() => deletarFichaTecnicaUsecase(''), throwsA(isA<IdNotFoundFichaTecnicaFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => fichaTecnicaRepository.deletarFichaTecnica('')).thenThrow(FichaTecnicaFailure());

        expect(() => deletarFichaTecnicaUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
