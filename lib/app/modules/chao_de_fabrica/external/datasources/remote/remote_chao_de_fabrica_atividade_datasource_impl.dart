import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/client/interceptors/api_key_interceptor.dart';
import 'package:pcp_flutter/app/core/client/interceptors/entidades_empresariais_interceptor.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/dto/filters/chao_de_fabrica_atividade_filter.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_atividade_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_chao_de_fabrica_atividade_datasource.dart';

class RemoteChaoDeFabricaAtividadeDatasourceImpl implements RemoteChaoDeFabricaAtividadeDatasource {
  final IClientService _clientService;

  RemoteChaoDeFabricaAtividadeDatasourceImpl({required IClientService clientService}) : _clientService = clientService;

  List<Interceptor> interceptors = [ApiKeyInterceptor(), EntidadesEmpresariaisInterceptor()];

  @override
  Future<List<ChaoDeFabricaAtividadeAggregate>> getAtividades(ChaoDeFabricaAtividadeFilter filter) async {
    try {
      Map<String, dynamic> queryParams = {
        'fields':
            'capacidade_utilizada, quantidade_produzida, produtos, produtos.produto, produtos.unidade, recurso, restricoes, restricoes.unidade, restricoes.restricao, unidade, operacao_ordem, operacao_ordem.ordem_de_producao, operacao_ordem.ordem_de_producao.unidade',
        'limit': 10,
      };

      if (filter.search.isNotEmpty) {
        queryParams['search'] = filter.search;
      }

      if (filter.centrosDeTrabalhos.isNotEmpty) {
        queryParams['centro_de_trabalho'] = filter.centrosDeTrabalhos.map((centroDeTrabalho) => centroDeTrabalho.id).toList().join(',');
      }

      if (filter.recursos.isNotEmpty) {
        queryParams['recurso'] = filter.recursos.map((recurso) => recurso.id).toList().join(',');
      }

      if (filter.atividadeStatus.isNotEmpty) {
        queryParams['status'] = filter.atividadeStatus.map((status) => status.value).toList().join(',');
      }

      if (filter.dataInicial.isNotEmpty) {
        queryParams['data_inicial'] = filter.dataInicial.dateFormat(format: 'yyyy-MM-dd');
      }

      if (filter.dataFinal.isNotEmpty) {
        queryParams['data_final'] = filter.dataFinal.dateFormat(format: 'yyyy-MM-dd');
      }

      if (filter.ultimaAtividadeId.isNotEmpty) {
        queryParams['after'] = filter.ultimaAtividadeId;
      }

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/atividadesrecursos',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
          body: <String, dynamic>{},
        ),
      );

      final data = List.from(response.data['result']).map((atividadesMap) {
        return RemoteChaoDeFabricaAtividadeMapper.fromMapToAtividadeAggregate(atividadesMap);
      }).toList();

      return data;
    } on ClientError catch (e) {
      throw DatasourceChaoDeFabricaFailure(
        errorMessage: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> getAtividade(String atividadeId) async {
    try {
      Map<String, dynamic> queryParams = {
        'fields':
            'capacidade_utilizada, quantidade_produzida, produtos, produtos.produto, produtos.unidade, recurso, restricoes, restricoes.unidade, restricoes.restricao, unidade, operacao_ordem, operacao_ordem.ordem_de_producao, operacao_ordem.ordem_de_producao.unidade',
      };

      final response = await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/atividadesrecursos/$atividadeId',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          queryParams: queryParams,
          body: <String, dynamic>{},
        ),
      );

      return RemoteChaoDeFabricaAtividadeMapper.fromMapToAtividadeAggregate(response.data);
    } on ClientError catch (e) {
      throw DatasourceChaoDeFabricaFailure(
        errorMessage: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> iniciarPreparacao(ChaoDeFabricaAtividadeAggregate atividade) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/atividadesrecursos/${atividade.id}/iniciar-preparacao',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          body: <String, dynamic>{},
        ),
      );

      return atividade.copyWith(status: AtividadeStatusEnum.emPreparacao);
    } on ClientError catch (e) {
      throw DatasourceChaoDeFabricaFailure(
        errorMessage: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> iniciarAtividade(ChaoDeFabricaAtividadeAggregate atividade) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/atividadesrecursos/${atividade.id}/iniciar',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          body: <String, dynamic>{},
        ),
      );

      return atividade.copyWith(status: AtividadeStatusEnum.iniciada);
    } on ClientError catch (e) {
      throw DatasourceChaoDeFabricaFailure(
        errorMessage: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> pausarAtividade(ChaoDeFabricaAtividadeAggregate atividade) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/atividadesrecursos/${atividade.id}/pausar',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          body: <String, dynamic>{},
        ),
      );

      return atividade.copyWith(status: AtividadeStatusEnum.pausada);
    } on ClientError catch (e) {
      throw DatasourceChaoDeFabricaFailure(
        errorMessage: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> continuarAtividade(ChaoDeFabricaAtividadeAggregate atividade) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/atividadesrecursos/${atividade.id}/continuar',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          body: <String, dynamic>{},
        ),
      );

      return atividade.copyWith(status: AtividadeStatusEnum.iniciada);
    } on ClientError catch (e) {
      throw DatasourceChaoDeFabricaFailure(
        errorMessage: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> encerrarAtividade(ChaoDeFabricaAtividadeAggregate atividade) async {
    try {
      await _clientService.request(
        ClientRequestParams(
          selectedApi: APIEnum.pcp,
          endPoint: '/atividadesrecursos/${atividade.id}/encerrar',
          method: ClientRequestMethods.GET,
          interceptors: interceptors,
          body: <String, dynamic>{},
        ),
      );

      return atividade.copyWith(status: AtividadeStatusEnum.encerrada);
    } on ClientError catch (e) {
      throw DatasourceChaoDeFabricaFailure(
        errorMessage: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }
}
