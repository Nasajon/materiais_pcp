import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/get_centro_trabalho_por_id_usecase.dart';

class CentroTrabalhoRepositoryMock extends Mock implements CentroTrabalhoRepository {}

void main() {
  late CentroTrabalhoRepository centroTrabalhoRepository;
  late GetCentroTrabalhoPorIdUsecase getCentroTrabalhoPorIdUsecase;

  setUp(() {
    centroTrabalhoRepository = CentroTrabalhoRepositoryMock();
    getCentroTrabalhoPorIdUsecase = GetCentroTrabalhoPorIdUsecaseImpl(centroTrabalhoRepository);
  });

  group('GetCentroTrabalhoPorIdUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar um CentroTrabalhoAggregate quando passar o id do centro de trabalho.', () async {
        when(() => centroTrabalhoRepository.getCentroTrabalhoPorId('1')).thenAnswer((_) async => CentroTrabalhoAggregate.empty());

        final response = await getCentroTrabalhoPorIdUsecase('1');

        expect(response, isA<CentroTrabalhoAggregate>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundCentroTrabalhoFailure quando não informar o id do centroTrabalho.', () async {
        expect(() => getCentroTrabalhoPorIdUsecase(''), throwsA(isA<IdNotFoundCentroTrabalhoFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => centroTrabalhoRepository.getCentroTrabalhoPorId('')).thenThrow(CentroTrabalhoFailure());

        expect(() => getCentroTrabalhoPorIdUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
