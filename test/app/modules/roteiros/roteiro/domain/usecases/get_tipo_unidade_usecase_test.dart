import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/tipo_unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_tipo_unidade_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_tipo_unidade_usecase.dart';

class GetTipoUnidadeRepositoryMock extends Mock implements GetTipoUnidadeRepository {}

void main() {
  late GetTipoUnidadeRepository getTipoUnidadeRepository;
  late GetTipoUnidadeUsecase getTipoUnidadeUsecase;

  setUp(() {
    getTipoUnidadeRepository = GetTipoUnidadeRepositoryMock();
    getTipoUnidadeUsecase = GetTipoUnidadeUsecaseImpl(getTipoUnidadeRepository);
  });

  group('GetTipoUnidadeUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista dos tipos de unidades quando passar ou não uma pesquisa.', () async {
        when(() => getTipoUnidadeRepository('')).thenAnswer((_) async => <TipoUnidadeEntity>[]);

        final response = await getTipoUnidadeUsecase('');

        expect(response, isA<List<TipoUnidadeEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => getTipoUnidadeRepository('')).thenThrow(RoteiroFailure());

        expect(() => getTipoUnidadeUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
