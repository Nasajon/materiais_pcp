import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';

abstract class RemoteGetGrupoDeRestricaoDatasource {
  Future<List<GrupoDeRestricaoEntity>> call(String search, {String? ultimoGrupoDeRestricaoId});
}
