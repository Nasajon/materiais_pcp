import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_restricao_por_grupo_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';

class GetRestricaoPorGrupoRepositoryMock extends Mock implements GetRestricaoPorGrupoRepository {}

void main() {
  late GetRestricaoPorGrupoRepository getRestricaoPorGrupoRepository;
  late GetRestricaoPorGrupoUsecase getRestricaoPorGrupoUsecase;

  setUp(() {
    getRestricaoPorGrupoRepository = GetRestricaoPorGrupoRepositoryMock();
    getRestricaoPorGrupoUsecase = GetRestricaoPorGrupoUsecaseImpl(getRestricaoPorGrupoRepository);
  });

  group('GetRestricaoPorGrupoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de recurso quando passar o id do grupo de restricao.', () async {
        when(() => getRestricaoPorGrupoRepository('1')).thenAnswer((_) async => <RestricaoAggregate>[]);

        final response = await getRestricaoPorGrupoUsecase('1');

        expect(response, isA<List<RestricaoAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundRoteiroFailure quando não informar o id do grupo de restricao.', () async {
        expect(() => getRestricaoPorGrupoUsecase(''), throwsA(isA<IdNotFoundRoteiroFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => getRestricaoPorGrupoRepository('')).thenThrow(RoteiroFailure());

        expect(() => getRestricaoPorGrupoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
