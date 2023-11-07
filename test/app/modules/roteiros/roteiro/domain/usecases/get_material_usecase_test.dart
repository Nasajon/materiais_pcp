import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_material_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_material_usecase.dart';

class GetMaterialRepositoryMock extends Mock implements GetMaterialRepository {}

void main() {
  late GetMaterialRepository getMaterialRepository;
  late GetMaterialUsecase getMaterialUsecase;

  setUp(() {
    getMaterialRepository = GetMaterialRepositoryMock();
    getMaterialUsecase = GetMaterialUsecaseImpl(getMaterialRepository);
  });

  group('GetMaterialUsecaseImpl -', () {
    group('Sucesso -', () {
      test('Deve retornar uma lista de material quando passar o id da ficha tecnica.', () async {
        when(() => getMaterialRepository('1')).thenAnswer((_) async => <MaterialEntity>[]);

        final response = await getMaterialUsecase('1');

        expect(response, isA<List<MaterialEntity>>());
      });
    });

    group('Falha -', () {
      test('Deve retornar o erro IdNotFoundRoteiroFailure quando não informar o id da ficha tecnica.', () async {
        expect(() => getMaterialUsecase(''), throwsA(isA<IdNotFoundRoteiroFailure>()));
      });

      test('Deve retornar uma falha quando ocorrer um erro no repository.', () async {
        when(() => getMaterialRepository('')).thenThrow(RoteiroFailure());

        expect(() => getMaterialUsecase(''), throwsA(isA<Failure>()));
      });
    });
  });
}
