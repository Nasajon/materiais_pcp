import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_grupo_de_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_grupo_de_recurso_usecase.dart';

class GetGrupoDeRecursoRepositoryMock extends Mock implements GetGrupoDeRecursoRepository {}

void main() {
  late GetGrupoDeRecursoRepository getGrupoDeRecursoRepository;
  late GetGrupoDeRecursoUsecase getGrupoDeRecursoUsecase;

  setUp(() {
    getGrupoDeRecursoRepository = GetGrupoDeRecursoRepositoryMock();
    getGrupoDeRecursoUsecase = GetGrupoDeRecursoUsecaseImpl(getGrupoDeRecursoRepository);
  });

  group('GetGrupoDeRecursoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista dos grupos quando passar ou não uma pesquisa.', () async {
        when(() => getGrupoDeRecursoRepository('')).thenAnswer((_) async => <GrupoDeRecursoEntity>[]);

        final response = await getGrupoDeRecursoUsecase('');

        expect(response, isA<List<GrupoDeRecursoEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => getGrupoDeRecursoRepository('')).thenThrow(RoteiroFailure());

        expect(() => getGrupoDeRecursoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
