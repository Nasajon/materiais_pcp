import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/unidade_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/unidade_repository.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/usecases/get_unidade_por_ids_usecase.dart';

class UnidadeRepositoryMock extends Mock implements UnidadeRepository {}

void main() {
  late UnidadeRepository unidadeRepository;
  late GetUnidadesPorIdsUsecase getUnidadesPorIdsUsecase;

  setUp(() {
    unidadeRepository = UnidadeRepositoryMock();
    getUnidadesPorIdsUsecase = GetUnidadesPorIdsUsecaseImpl(unidadeRepository);
  });

  group('GetProdutoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de produto quando passar ou não uma pesquisa.', () async {
        when(() => unidadeRepository.getTodasUnidadesPorIds([''])).thenAnswer((_) async => <String, UnidadeEntity>{});

        final response = await getUnidadesPorIdsUsecase(['']);

        expect(response, isA<Map<String, UnidadeEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => unidadeRepository.getTodasUnidadesPorIds([''])).thenThrow(UnidadeFailure());

        expect(() => getUnidadesPorIdsUsecase(['']), throwsA(isA<UnidadeFailure>()));
      });
    });
  });
}
