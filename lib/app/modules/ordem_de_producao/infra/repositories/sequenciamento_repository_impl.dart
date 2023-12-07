import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/dto/sequenciamento_dto.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/sequenciamento_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_sequenciamento_datasource.dart';

class SequenciamentoRepositoryImpl implements SequenciamentoRepository {
  final RemoteSequenciamentoDatasource _remoteSequenciamentoDatasource;

  const SequenciamentoRepositoryImpl(this._remoteSequenciamentoDatasource);

  @override
  Future<SequenciamentoAggregate> gerarSequencimaneto(SequenciamentoDTO sequenciamento) {
    return _remoteSequenciamentoDatasource.gerarSequencimaneto(sequenciamento);
  }

  @override
  Future<bool> sequenciarOrdemDeProducao(SequenciamentoAggregate sequenciamento) {
    return _remoteSequenciamentoDatasource.sequenciarOrdemDeProducao(sequenciamento);
  }
}
