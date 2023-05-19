import 'package:flutter_core/ana_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp_flutter/app/modules/recurso/domain/entities/recurso.dart';
import 'package:pcp_flutter/app/modules/recurso/external/datasources/remote/recurso_datasource_impl.dart';

import '../../../utils/client_request_params_fake.dart';
import '../../../utils/client_service_mock.dart';
import '../../utils/data.dart';
import '../../utils/recurso_factory.dart';

void main() {
  final clientService = ClientServiceMock();
  final datasource = RecursoDatasourceImpl(clientService);

  setUpAll(() {
    registerFallbackValue(ClientRequestParamsFake());
  });

  group('get list', () {
    test('deve retornar uma lista de grupo de recursos', () async {
      when(() => clientService.request(any())).thenAnswer((_) async => const ClientResponse(data: recursosSuccessData, statusCode: 200));

      final result = await datasource.getList('');

      expect(result, isA<List<Recurso>>());

      verify(() => clientService.request(any()));
    });
  });

  group('get item', () {
    test('deve retornar um grupo de recursos', () async {
      when(() => clientService.request(any())).thenAnswer((_) async => const ClientResponse(data: recursoSuccessData, statusCode: 200));

      final result = await datasource.getItem('');

      expect(result, isA<Recurso>());

      verify(() => clientService.request(any()));
    });
  });

  group('insert item', () {
    test('deve inserir um grupo de recursos', () async {
      when(() => clientService.request(any())).thenAnswer((_) async => const ClientResponse(data: recursoSuccessData, statusCode: 200));

      final result = await datasource.insertItem(RecursoFactory.create());

      expect(result, isA<Recurso>());

      verify(() => clientService.request(any()));
    });
  });

  group('put item', () {
    test('deve atualizar um grupo de recurso', () async {
      when(() => clientService.request(any())).thenAnswer((_) async => const ClientResponse(data: recursoSuccessData, statusCode: 200));

      final result = await datasource.updateItem(RecursoFactory.create(id: '00000000-0000-0000-0000-000000000001'));

      expect(result, isA<Recurso>());

      verify(() => clientService.request(any()));
    });
  });
}
