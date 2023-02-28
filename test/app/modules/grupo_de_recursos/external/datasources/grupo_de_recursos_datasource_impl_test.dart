import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/external/datasources/grupo_de_recurso_datasource_impl.dart';

import '../../../utils/client_request_params_fake.dart';
import '../../../utils/client_service_mock.dart';
import '../../utils/data.dart';
import '../../utils/grupo_de_recurso_factory.dart';

void main() {
  final clientService = ClientServiceMock();
  final datasource = GrupoDeRecursoDatasourceImpl(clientService);

  setUpAll(() {
    registerFallbackValue(ClientRequestParamsFake());
  });

  group('get list', () {
    test('deve retornar uma lista de grupo de recursos', () async {
      when(() => clientService.request(any())).thenAnswer((_) async =>
          const ClientResponse(
              data: gruposDeRecursosSuccessData, statusCode: 200));

      final result = await datasource.getList('');

      expect(result, isA<List<GrupoDeRecurso>>());

      verify(() => clientService.request(any()));
    });
  });

  group('get item', () {
    test('deve retornar um grupo de recursos', () async {
      when(() => clientService.request(any())).thenAnswer((_) async =>
          const ClientResponse(
              data: grupoDeRecursoSuccessData, statusCode: 200));

      final result = await datasource.getItem('');

      expect(result, isA<GrupoDeRecurso>());

      verify(() => clientService.request(any()));
    });
  });

  group('insert item', () {
    test('deve inserir um grupo de recursos', () async {
      when(() => clientService.request(any())).thenAnswer((_) async =>
          const ClientResponse(
              data: grupoDeRecursoSuccessData, statusCode: 200));

      final result =
          await datasource.insertItem(GrupoDeRecursoFactory.create());

      expect(result, isA<GrupoDeRecurso>());

      verify(() => clientService.request(any()));
    });
  });

  group('put item', () {
    test('deve atualizar um grupo de recurso', () async {
      when(() => clientService.request(any())).thenAnswer((_) async =>
          const ClientResponse(
              data: grupoDeRecursoSuccessData, statusCode: 200));

      final result = await datasource.updateItem(GrupoDeRecursoFactory.create(
          id: '00000000-0000-0000-0000-000000000001'));

      expect(result, isA<GrupoDeRecurso>());

      verify(() => clientService.request(any()));
    });
  });
}
