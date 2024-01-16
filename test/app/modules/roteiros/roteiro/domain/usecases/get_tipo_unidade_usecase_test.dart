import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_unidade_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_unidade_usecase.dart';

class GetUnidadeRepositoryMock extends Mock implements GetUnidadeRepository {}

void main() {
  late GetUnidadeRepository getUnidadeRepository;
  late GetUnidadeUsecase getUnidadeUsecase;

  setUp(() {
    getUnidadeRepository = GetUnidadeRepositoryMock();
    getUnidadeUsecase = GetUnidadeUsecaseImpl(getUnidadeRepository);
  });

  group('GetUnidadeUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista dos tipos de unidades quando passar ou não uma pesquisa.', () async {
        when(() => getUnidadeRepository('')).thenAnswer((_) async => <UnidadeEntity>[]);

        final response = await getUnidadeUsecase('');

        expect(response, isA<List<UnidadeEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => getUnidadeRepository('')).thenThrow(RoteiroFailure());

        expect(() => getUnidadeUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
