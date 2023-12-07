import 'dart:convert';

import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/dto/sequenciamento_dto.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_sequenciamento_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_sequenciamento_datasource.dart';

class RemoteSequenciamentoDatasourceImpl implements RemoteSequenciamentoDatasource {
  final IClientService _clientService;

  RemoteSequenciamentoDatasourceImpl(this._clientService);

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<SequenciamentoAggregate> gerarSequencimaneto(SequenciamentoDTO sequenciamento) async {
    try {
      Map<String, dynamic> body = {
        'ordens': sequenciamento.ordensIds,
        'recursos': sequenciamento.recursosIds,
        'restricoes': sequenciamento.restricoesIds,
      };

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/sequenciamentos/sequenciar',
          method: ClientRequestMethods.POST,
          interceptors: interceptors,
          body: body,
        ),
      );

      final data = RemoteSequenciamentoMapper.fromMapToSequenciamento(response.data);

      return data;
    } on ClientError catch (e) {
      throw DatasourceOrdemDeProducaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<bool> sequenciarOrdemDeProducao(SequenciamentoAggregate sequenciamento) async {
    try {
      print(jsonEncode(RemoteSequenciamentoMapper.fromSequenciamentoTopMap(sequenciamento)));
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/sequenciamentos/aprovar',
          method: ClientRequestMethods.POST,
          interceptors: interceptors,
          body: RemoteSequenciamentoMapper.fromSequenciamentoTopMap(sequenciamento),
        ),
      );

      return true;
    } on ClientError catch (e) {
      throw DatasourceOrdemDeProducaoFailure(errorMessage: e.message, stackTrace: e.stackTrace);
    }
  }
}
