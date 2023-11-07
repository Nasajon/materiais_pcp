import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_grupo_de_restricao_repository.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/datasources/remotes/remote_get_grupo_de_restricao_datasource.dart';

class GetGrupoDeRestricaoRepositoryImpl implements GetGrupoDeRestricaoRepository {
  final RemoteGetGrupoDeRestricaoDatasource _remoteGetGrupoDeRestricaoDatasource;

  const GetGrupoDeRestricaoRepositoryImpl(this._remoteGetGrupoDeRestricaoDatasource);

  @override
  Future<List<GrupoDeRestricaoEntity>> call(String search) {
    return _remoteGetGrupoDeRestricaoDatasource(search);
  }
}
