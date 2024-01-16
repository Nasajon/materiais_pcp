import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_restricao_por_grupo_repository.dart';
import 'package:pcp_flutter/app/modules/roteiro/infra/datasources/remotes/remote_get_restricao_por_grupo_datasource.dart';

class GetRestricaoPorGrupoRepositoryImpl implements GetRestricaoPorGrupoRepository {
  final RemoteGetRestricaoPorGrupoDatasource _remoteGetRestricaoPorGrupoDatasource;

  const GetRestricaoPorGrupoRepositoryImpl(this._remoteGetRestricaoPorGrupoDatasource);

  @override
  Future<List<RestricaoAggregate>> call(String grupoDeRestricaoId) {
    return _remoteGetRestricaoPorGrupoDatasource(grupoDeRestricaoId);
  }
}
