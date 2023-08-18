import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_restricao_by_grupo_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_by_grupo_usecase.dart';

class GetRestricaoByGrupoRepositoryMock extends Mock implements GetRestricaoByGrupoRepository {}

void main() {
  late GetRestricaoByGrupoRepository getRestricaoByGrupoRepository;
  late GetRestricaoByGrupoUsecase getRestricaoByGrupoUsecase;

  setUp(() {
    getRestricaoByGrupoRepository = GetRestricaoByGrupoRepositoryMock();
    getRestricaoByGrupoUsecase = GetRestricaoByGrupoUsecaseImpl(getRestricaoByGrupoRepository);
  });

  group('GetRestricaoByGrupoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de recurso quando passar o id do grupo de restricao.', () async {
        when(() => getRestricaoByGrupoRepository('1')).thenAnswer((_) async => <RestricaoAggregate>[]);

        final response = await getRestricaoByGrupoUsecase('1');

        expect(response, isA<List<RestricaoAggregate>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundRoteiroFailure quando não informar o id do grupo de restricao.', () async {
        expect(() => getRestricaoByGrupoUsecase(''), throwsA(isA<IdNotFoundRoteiroFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => getRestricaoByGrupoRepository('')).thenThrow(RoteiroFailure());

        expect(() => getRestricaoByGrupoUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
