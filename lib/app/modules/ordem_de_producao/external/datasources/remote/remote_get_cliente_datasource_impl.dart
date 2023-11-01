import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_cliente_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_cliente_datasource.dart';

class RemoteGetClienteDatasourceImpl implements RemoteGetClienteDatasource {
  final IClientService _clientService;

  RemoteGetClienteDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<ClienteEntity>> call({String search = '', String ultimoId = ''}) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (ultimoId.isNotEmpty) {
        queryParams['after'] = ultimoId;
      }

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/clientes',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      final data = List.from(response.data).map((map) => RemoteClienteMapper.fromMapToCliente(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceOrdemDeProducaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
