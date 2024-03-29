import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/repositories/get_grupo_de_restricao_repository.dart';
import 'package:pcp_flutter/app/modules/restricao/infra/datasources/remote/remote_get_grupo_de_restricao_datasource.dart';

class GetGrupoDeRestricaoRepositoryImpl implements GetGrupoDeRestricaoRepository {
  final RemoteGetGrupoDeRestricaoDatasource _remoteGetGrupoDeRestricaoDatasource;

  const GetGrupoDeRestricaoRepositoryImpl(this._remoteGetGrupoDeRestricaoDatasource);

  @override
  Future<List<RestricaoGrupoDeRestricaoEntity>> call(String search, {String? ultimoGrupoDeRestricaoId}) {
    return _remoteGetGrupoDeRestricaoDatasource(search, ultimoGrupoDeRestricaoId: ultimoGrupoDeRestricaoId);
  }
}
