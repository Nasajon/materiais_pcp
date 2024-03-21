import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/dto/filters/chao_de_fabrica_atividade_filter.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_atividade_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_chao_de_fabrica_atividade_datasource.dart';

class ChaoDeFabricaAtividadeRepositoryImpl implements ChaoDeFabricaAtividadeRepository {
  final RemoteChaoDeFabricaAtividadeDatasource _atividadeDatasource;

  const ChaoDeFabricaAtividadeRepositoryImpl({required RemoteChaoDeFabricaAtividadeDatasource atividadeDatasource})
      : _atividadeDatasource = atividadeDatasource;

  @override
  Future<List<ChaoDeFabricaAtividadeAggregate>> getAtividades(ChaoDeFabricaAtividadeFilter filter) {
    return _atividadeDatasource.getAtividades(filter);
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> getAtividade(String atividadeId) {
    return _atividadeDatasource.getAtividade(atividadeId);
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> iniciarPreparacao(ChaoDeFabricaAtividadeAggregate atividade) {
    return _atividadeDatasource.iniciarPreparacao(atividade);
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> iniciarAtividade(ChaoDeFabricaAtividadeAggregate atividade) {
    return _atividadeDatasource.iniciarAtividade(atividade);
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> continuarAtividade(ChaoDeFabricaAtividadeAggregate atividade) {
    return _atividadeDatasource.continuarAtividade(atividade);
  }

  @override
  Future<ChaoDeFabricaAtividadeAggregate> pausarAtividade(ChaoDeFabricaAtividadeAggregate atividade) {
    return _atividadeDatasource.pausarAtividade(atividade);
  }
}
