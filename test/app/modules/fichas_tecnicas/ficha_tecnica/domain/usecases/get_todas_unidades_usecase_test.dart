import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/unidade_repository.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/usecases/get_todas_unidades_usecase.dart';

class UnidadeRepositoryMock extends Mock implements UnidadeRepository {}

void main() {
  late UnidadeRepository unidadeRepository;
  late GetTodasUnidadesUsecase getTodasUnidadesUsecase;

  setUp(() {
    unidadeRepository = UnidadeRepositoryMock();
    getTodasUnidadesUsecase = GetTodasUnidadesUsecaseImpl(unidadeRepository);
  });

  group('GetUnidadeUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista dos tipos de unidades quando passar ou não uma pesquisa.', () async {
        when(() => unidadeRepository.getTodasUnidades('')).thenAnswer((_) async => <UnidadeEntity>[]);

        final response = await getTodasUnidadesUsecase('');

        expect(response, isA<List<UnidadeEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => unidadeRepository.getTodasUnidades('')).thenThrow(FichaTecnicaFailure());

        expect(() => getTodasUnidadesUsecase(''), throwsA(isA<FichaTecnicaFailure>()));
      });
    });
  });
}
