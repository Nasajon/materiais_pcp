import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_ficha_tecnica_por_id_usecase.dart';

class FichaTecnicaRepositoryMock extends Mock implements FichaTecnicaRepository {}

void main() {
  late FichaTecnicaRepository fichaTecnicaRepository;
  late GetFichaTecnicaPorIdUsecase getFichaTecnicaPorIdUsecase;

  setUp(() {
    fichaTecnicaRepository = FichaTecnicaRepositoryMock();
    getFichaTecnicaPorIdUsecase = GetFichaTecnicaPorIdUsecaseImpl(fichaTecnicaRepository);
  });

  group('GetFichaTecnicaPorIdUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma FichaTecnicaAggregate quando passar o id da ficha.', () async {
        when(() => fichaTecnicaRepository.getFichaTecnicaPorId('1')).thenAnswer((_) async => FichaTecnicaAggregate.empty());

        final response = await getFichaTecnicaPorIdUsecase('1');

        expect(response, isA<FichaTecnicaAggregate>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundRoteiroFailure quando não informar o id da ficha.', () async {
        expect(() => getFichaTecnicaPorIdUsecase(''), throwsA(isA<IdNotFoundFichaTecnicaFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => fichaTecnicaRepository.getFichaTecnicaPorId('')).thenThrow(FichaTecnicaFailure());

        expect(() => getFichaTecnicaPorIdUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
