import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/atualizar_centro_trabalho_usecase.dart';

class CentroTrabalhoRepositoryMock extends Mock implements CentroTrabalhoRepository {}

void main() {
  late CentroTrabalhoRepository centroTrabalhoRepository;
  late AtualizarCentroTrabalhoUsecase atualizarCentroTrabalhoUsecase;

  setUp(() {
    centroTrabalhoRepository = CentroTrabalhoRepositoryMock();
    atualizarCentroTrabalhoUsecase = AtualizarCentroTrabalhoUsecaseImpl(centroTrabalhoRepository);
  });

  group('AtualizarCentroTrabalhoUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve atualizar um centro de trabalho quando os dados forem valido.', () async {
        when(() => centroTrabalhoRepository.atualizarCentroTrabalho(centroTrabalho)).thenAnswer((_) async => true);

        final response = await atualizarCentroTrabalhoUsecase(centroTrabalho);

        expect(response, isA<bool>());
        expect(response, true);
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundCentroTrabalhoFailure quando não informar o id do centro de trabalho.', () async {
        expect(() => atualizarCentroTrabalhoUsecase(CentroTrabalhoAggregate.empty()), throwsA(isA<IdNotFoundCentroTrabalhoFailure>()));
      });

      test('Deve retornar o erro CentroTrabalhoIsNotValidFailure quando os dados não são valido.', () async {
        expect(() => atualizarCentroTrabalhoUsecase(CentroTrabalhoAggregate.empty().copyWith(id: '1')),
            throwsA(isA<CentroTrabalhoIsNotValidFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => centroTrabalhoRepository.atualizarCentroTrabalho(centroTrabalho)).thenThrow(CentroTrabalhoFailure());

        expect(() => atualizarCentroTrabalhoUsecase(centroTrabalho), throwsA(isA<Failure>()));
      });
    });
  });
}

final centroTrabalho = CentroTrabalhoAggregate(
  id: '123',
  codigo: CodigoVO(1),
  nome: TextVO('Teste'),
  turnos: [
    TurnoTrabalhoEntity(
      id: '',
      codigo: CodigoVO(1),
      nome: '',
    ),
  ],
);
