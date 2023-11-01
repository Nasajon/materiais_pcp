import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_operacao_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_operacao_datasource.dart';

class RemoteGetOperacaoDatasourceImpl implements RemoteGetOperacaoDatasource {
  final IClientService _clientService;

  RemoteGetOperacaoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<OperacaoAggregate>> call(String roteiroId) async {
    try {
      Map<String, dynamic> queryParams = {
        'fields':
            'operacoes.centro_de_trabalho,operacoes.produtos.produto,operacoes.produtos.unidade,operacoes.grupos_recursos.grupo_de_recurso,operacoes.grupos_recursos.recursos.recurso',
      };

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/roteiros/$roteiroId',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
        ),
      );

      final data = List.from(response.data['operacoes']).map((map) => RemoteOperacaoMapper.fromMapToOperacaoEntity(map)).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceOrdemDeProducaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
