import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_ficha_tecnica_usecase.dart';

class GetFichaTecnicaRepositoryMock extends Mock implements GetFichaTecnicaRepository {}

void main() {
  late GetFichaTecnicaRepository getFichaTecnicaRepository;
  late GetFichaTecnicaUsecase getFichaTecnicaUsecase;

  setUp(() {
    getFichaTecnicaRepository = GetFichaTecnicaRepositoryMock();
    getFichaTecnicaUsecase = GetFichaTecnicaUsecaseImpl(getFichaTecnicaRepository);
  });

  group('GetFichaTecnicaUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de ficha tecnica quando passar ou não uma pesquisa.', () async {
        when(() => getFichaTecnicaRepository('')).thenAnswer((_) async => <FichaTecnicaEntity>[]);

        final response = await getFichaTecnicaUsecase('');

        expect(response, isA<List<FichaTecnicaEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => getFichaTecnicaRepository('')).thenThrow(RoteiroFailure());

        expect(() => getFichaTecnicaUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
