import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/atualizar_ficha_tecnica_usecase.dart';

import '../entities/inserir_atualizar_ficha_tecnica.dart';

class FichaTecnicaRepositoryMock extends Mock implements FichaTecnicaRepository {}

void main() {
  late FichaTecnicaRepository fichaTecnicaRepository;
  late AtualizarFichaTecnicaUsecase atualizarFichaTecnicaUsecase;

  setUp(() {
    fichaTecnicaRepository = FichaTecnicaRepositoryMock();
    atualizarFichaTecnicaUsecase = AtualizarFichaTecnicaUsecaseImpl(fichaTecnicaRepository);
  });

  group("Success -  ", () {
    test("Deve Editar uma ficha técnica", () async {
      when(() => fichaTecnicaRepository.atualizarFichaTecnica(fichaTecnicaAtualizar)).thenAnswer((_) async => true);
      final result = await atualizarFichaTecnicaUsecase(fichaTecnicaAtualizar);
      expect(result, isA<bool>());
      expect(result, true);
    });
  });

  group('Failure - ', () {
    test("Deve falhar caso tente editar uma ficha sem definir o ID",
        () => {expect(() => atualizarFichaTecnicaUsecase(FichaTecnicaAggregate.empty()), throwsA(isA<IdNotFoundFichaTecnicaFailure>()))});

    test(
        "Deve falhar caso tente editar uma ficha sem materiais",
        () => {
              expect(() => atualizarFichaTecnicaUsecase(FichaTecnicaAggregate.empty().copyWith(id: '6d28e0be-3274-47ec-9f35-fd619b30c069')),
                  throwsA(isA<EmptyMaterialFichaTecnicaFailure>()))
            });

    test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
      when(() => fichaTecnicaRepository.atualizarFichaTecnica(fichaTecnicaCriar)).thenThrow(FichaTecnicaFailure());

      expect(() => atualizarFichaTecnicaUsecase(fichaTecnicaCriar), throwsA(isA<FichaTecnicaFailure>()));
    });
  });
}
