import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_restricao_by_grupo_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_restricao_by_grupo_datasource.dart';

class GetRestricaoByGrupoRepositoryImpl implements GetRestricaoByGrupoRepository {
  final RemoteGetRestricaoByGrupoDatasource _remoteGetRestricaoByGrupoDatasource;

  const GetRestricaoByGrupoRepositoryImpl(this._remoteGetRestricaoByGrupoDatasource);

  @override
  Future<List<RestricaoEntity>> call(String grupoDeRestricaoId) {
    return _remoteGetRestricaoByGrupoDatasource(grupoDeRestricaoId);
  }
}
