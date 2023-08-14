import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_grupo_de_restricao_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_grupo_de_restricao_usecase.dart';

class GetGrupoDeRestricaoRepositoryMock extends Mock implements GetGrupoDeRestricaoRepository {}

void main() {
  late GetGrupoDeRestricaoRepository getGrupoDeRestricaoRepository;
  late GetGrupoDeRestricaoUsecase getGrupoDeRestricaoUsecase;

  setUp(() {
    getGrupoDeRestricaoRepository = GetGrupoDeRestricaoRepositoryMock();
    getGrupoDeRestricaoUsecase = GetGrupoDeRestricaoUsecaseImpl(getGrupoDeRestricaoRepository);
  });

  group('GetGrupoDeRestricaoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista dos grupos de restrições quando passar ou não uma pesquisa.', () async {
        when(() => getGrupoDeRestricaoRepository('')).thenAnswer((_) async => <GrupoDeRestricaoEntity>[]);

        final response = await getGrupoDeRestricaoUsecase('');

        expect(response, isA<List<GrupoDeRestricaoEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar uma falha quando ocorrer um erro na pesquisa.', () async {
        when(() => getGrupoDeRestricaoRepository('')).thenThrow(RoteiroFailure());

        expect(() => getGrupoDeRestricaoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
