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
}

const jsonMock = {
  'tempo_inicial': '2023-11-14T19:51:56',
  'sequenciamento_recursos': [
    {
      'recurso': {'recurso': '204c2640-233c-49fd-8e2f-887d26e94887', 'codigo': '2', 'nome': 'Batedeira 1'},
      'events': [
        {
          'evento_recurso': 'ca0a90d6-dfc5-44e7-9ff7-89a317f53f16',
          'recurso': '204c2640-233c-49fd-8e2f-887d26e94887',
          'capacidade': 1,
          'ordem_de_producao': {
            'ordem_de_producao': '1ff40fed-e294-438f-abeb-72c60d636aa7',
            'codigo': '1',
            'fim_previsto': '2023-11-09T00:00:00',
            'quantidade': 12.0,
            'origem': 'pcp',
            'status': 'aprovada',
            'prioridade': '1'
          },
          'operacao_roteiro': {
            'operacao': '4074d62f-6d25-4444-8c54-b181adedcda0',
            'codigo': '10',
            'nome': '001',
            'roteiro': 'a5b96fe7-46d2-4fb3-96df-4723457cea9f',
            'ordem': 1,
            'razao_conversao': 1.0,
            'medicao_tempo': 'tempo_fixo',
            'preparacao': '00:10:00',
            'execucao': '00:30:00'
          },
          'inicio_planejado': '2023-11-14T20:01:56',
          'fim_planejado': '2023-11-14T20:31:56'
        }
      ]
    },
    {
      'recurso': {'recurso': '78522190-6377-4987-833e-89308cdaa8ff', 'codigo': '3', 'nome': 'Batedeira 2'},
      'events': [
        {
          'evento_recurso': '447d2b01-627d-4dd9-9dbd-9f8bf506780f',
          'recurso': '78522190-6377-4987-833e-89308cdaa8ff',
          'capacidade': 2,
          'ordem_de_producao': {
            'ordem_de_producao': '1ff40fed-e294-438f-abeb-72c60d636aa7',
            'codigo': '1',
            'fim_previsto': '2023-11-09T00:00:00',
            'quantidade': 12.0,
            'origem': 'pcp',
            'status': 'aprovada',
            'prioridade': '1'
          },
          'operacao_roteiro': {
            'operacao': '4074d62f-6d25-4444-8c54-b181adedcda0',
            'codigo': '10',
            'nome': '001',
            'roteiro': 'a5b96fe7-46d2-4fb3-96df-4723457cea9f',
            'ordem': 1,
            'razao_conversao': 1.0,
            'medicao_tempo': 'tempo_fixo',
            'preparacao': '00:10:00',
            'execucao': '00:30:00'
          },
          'inicio_planejado': '2023-11-14T20:01:56',
          'fim_planejado': '2023-11-14T20:31:56'
        }
      ]
    }
  ],
  'sequenciamento_restricoes': [
    {
      'restricao': {'restricao': '9415385a-0f92-476d-90b8-3f2f0a198e27', 'codigo': '1', 'nome': 'Marcelo'},
      'events': [
        {
          'evento_restricao': '010eac2d-742c-4e67-9ae8-65b67ec1cdd3',
          'evento_recurso': 'ca0a90d6-dfc5-44e7-9ff7-89a317f53f16',
          'restricao': '9415385a-0f92-476d-90b8-3f2f0a198e27',
          'recurso': {'recurso': '204c2640-233c-49fd-8e2f-887d26e94887', 'codigo': '2', 'nome': 'Batedeira 1'},
          'inicio_planejado': '2023-11-14T19:51:56',
          'capacidade': 1.0,
          'operacao_roteiro': {
            'operacao': '4074d62f-6d25-4444-8c54-b181adedcda0',
            'codigo': '10',
            'nome': '001',
            'roteiro': 'a5b96fe7-46d2-4fb3-96df-4723457cea9f',
            'ordem': 1,
            'razao_conversao': 1.0,
            'medicao_tempo': 'tempo_fixo',
            'preparacao': '00:10:00',
            'execucao': '00:30:00'
          },
          'ordem_de_producao': '1ff40fed-e294-438f-abeb-72c60d636aa7',
          'fim_planejado': '2023-11-14T20:01:56'
        }
      ]
    },
    {
      'restricao': {'restricao': 'a5c4608e-7afe-4318-ae82-5eb23bd8ad1d', 'codigo': '2', 'nome': 'Rodrigo'},
      'events': [
        {
          'evento_restricao': '45ec27a5-a712-4eb8-9998-99e9e4fb57a2',
          'evento_recurso': '447d2b01-627d-4dd9-9dbd-9f8bf506780f',
          'restricao': 'a5c4608e-7afe-4318-ae82-5eb23bd8ad1d',
          'recurso': {'recurso': '78522190-6377-4987-833e-89308cdaa8ff', 'codigo': '3', 'nome': 'Batedeira 2'},
          'inicio_planejado': '2023-11-14T19:51:56',
          'capacidade': 1.0,
          'operacao_roteiro': {
            'operacao': '4074d62f-6d25-4444-8c54-b181adedcda0',
            'codigo': '10',
            'nome': '001',
            'roteiro': 'a5b96fe7-46d2-4fb3-96df-4723457cea9f',
            'ordem': 1,
            'razao_conversao': 1.0,
            'medicao_tempo': 'tempo_fixo',
            'preparacao': '00:10:00',
            'execucao': '00:30:00'
          },
          'ordem_de_producao': '1ff40fed-e294-438f-abeb-72c60d636aa7',
          'fim_planejado': '2023-11-14T20:01:56'
        }
      ]
    }
  ]
};
