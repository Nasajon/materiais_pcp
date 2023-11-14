import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_centro_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_centro_de_trabalho_usecase.dart';

class GetCentroDeTrabalhoRepositoryMock extends Mock implements GetCentroDeTrabalhoRepository {}

void main() {
  late GetCentroDeTrabalhoRepository getCentroDeTrabalhoRepository;
  late GetCentroDeTrabalhoUsecase getCentroDeTrabalhoUsecase;

  setUp(() {
    getCentroDeTrabalhoRepository = GetCentroDeTrabalhoRepositoryMock();
    getCentroDeTrabalhoUsecase = GetCentroDeTrabalhoUsecaseImpl(getCentroDeTrabalhoRepository);
  });

  group('GetCentroDeTrabalhoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de centros de trabalho quando passar ou não uma pesquisa.', () async {
        when(() => getCentroDeTrabalhoRepository('')).thenAnswer((_) async => <CentroDeTrabalhoEntity>[]);

        final response = await getCentroDeTrabalhoUsecase('');

        expect(response, isA<List<CentroDeTrabalhoEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => getCentroDeTrabalhoRepository('')).thenThrow(RoteiroFailure());

        expect(() => getCentroDeTrabalhoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
