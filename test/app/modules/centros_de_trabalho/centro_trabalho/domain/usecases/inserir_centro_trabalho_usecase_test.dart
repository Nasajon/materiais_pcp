import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/inserir_centro_trabalho_usecase.dart';

class CentroTrabalhoRepositoryMock extends Mock implements CentroTrabalhoRepository {}

void main() {
  late CentroTrabalhoRepository centroTrabalhoRepository;
  late InserirCentroTrabalhoUsecase inserirCentroTrabalhoUsecase;

  setUp(() {
    centroTrabalhoRepository = CentroTrabalhoRepositoryMock();
    inserirCentroTrabalhoUsecase = InserirCentroTrabalhoUsecaseImpl(centroTrabalhoRepository);
  });

  group('InserirCentroTrabalhoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve inserir um centro de trabalho quando os dados forem valido.', () async {
        when(() => centroTrabalhoRepository.inserirCentroTrabalho(centroTrabalho)).thenAnswer((_) async => centroTrabalho);

        final response = await inserirCentroTrabalhoUsecase(centroTrabalho);

        expect(response, isA<CentroTrabalhoAggregate>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IncompleteOrMissingDataCentroTrabalhoFailure quando os dados não são valido.', () async {
        expect(() => inserirCentroTrabalhoUsecase(CentroTrabalhoAggregate.empty()),
            throwsA(isA<IncompleteOrMissingDataCentroTrabalhoFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => centroTrabalhoRepository.inserirCentroTrabalho(centroTrabalho)).thenThrow(CentroTrabalhoFailure());

        expect(() => inserirCentroTrabalhoUsecase(centroTrabalho), throwsA(isA<Failure>()));
      });
    });
  });
}

final centroTrabalho = CentroTrabalhoAggregate(
  id: '123',
  codigo: CodigoVO(1),
  nome: TextVO('Teste'),
  turnos: [TurnoTrabalhoEntity(id: '123', codigo: CodigoVO(1), nome: 'Teste')],
);
