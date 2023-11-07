import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_operacao_repository.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/infra/datasources/remote/remote_get_operacao_datasource.dart';

class GetOperacaoRepositoryImpl implements GetOperacaoRepository {
  final RemoteGetOperacaoDatasource _remoteGetOperacaoDatasource;

  const GetOperacaoRepositoryImpl(this._remoteGetOperacaoDatasource);

  @override
  Future<List<OperacaoAggregate>> call(String roteiroId) {
    return _remoteGetOperacaoDatasource(roteiroId);
  }
}
