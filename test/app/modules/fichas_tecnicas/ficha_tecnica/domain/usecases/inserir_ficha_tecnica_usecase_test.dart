import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/usecases/inserir_ficha_tecnica_usecase.dart';

import '../entities/inserir_atualizar_ficha_tecnica.dart';

class FichaTecnicaRepositoryMock extends Mock implements FichaTecnicaRepository {}

void main() {
  late FichaTecnicaRepository fichaTecnicaRepository;
  late InserirFichaTecnicaUsecase inserirFichaTecnicaUsecase;

  setUp(() {
    fichaTecnicaRepository = FichaTecnicaRepositoryMock();
    inserirFichaTecnicaUsecase = InserirFichaTecnicaUsecaseImpl(fichaTecnicaRepository);
  });

  group('InserirFichaTecnicaUsecase -', () {
    group('Sucesso -', () {
      test('Deve inserir uma  ficha tecnica quando os dados forem validos.', () async {
        when(() => fichaTecnicaRepository.inserirFichaTecnica(fichaTecnicaCriar))
            .thenAnswer((_) async => fichaTecnicaCriar.copyWith(id: '3d089a9f-8303-487c-b50d-e5b37ae1b497'));

        final response = await inserirFichaTecnicaUsecase(fichaTecnicaCriar);

        expect(response, isA<FichaTecnicaAggregate>());
        expect(response.id, '3d089a9f-8303-487c-b50d-e5b37ae1b497');
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IncompleteOrMissingDataFichaTecnicaFailure quando os dados não são valido.', () async {
        expect(() => inserirFichaTecnicaUsecase(FichaTecnicaAggregate.empty()), throwsA(isA<IncompleteOrMissingDataFichaTecnicaFailure>()));
      });
      test('Deve retornar o erro IdMustBeEmptyFichaTecnicaFailure quando o id estiver preenchido.', () async {
        expect(() => inserirFichaTecnicaUsecase(fichaTecnicaAtualizar), throwsA(isA<IdMustBeEmptyFichaTecnicaFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => fichaTecnicaRepository.inserirFichaTecnica(fichaTecnicaCriar)).thenThrow(FichaTecnicaFailure());

        expect(() => inserirFichaTecnicaUsecase(fichaTecnicaCriar), throwsA(isA<FichaTecnicaFailure>()));
      });
    });
  });
}
