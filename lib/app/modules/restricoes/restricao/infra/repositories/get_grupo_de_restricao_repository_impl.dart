import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/repositories/get_grupo_de_restricao_repository.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/infra/datasources/remote/remote_get_grupo_de_restricao_datasource.dart';

class GetGrupoDeRestricaoRepositoryImpl implements GetGrupoDeRestricaoRepository {
  final RemoteGetGrupoDeRestricaoDatasource _remoteGetGrupoDeRestricaoDatasource;

  const GetGrupoDeRestricaoRepositoryImpl(this._remoteGetGrupoDeRestricaoDatasource);

  @override
  Future<List<GrupoDeRestricaoEntity>> call() {
    return _remoteGetGrupoDeRestricaoDatasource();
  }
}
