import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_grupo_de_restricao_entity.dart';

abstract class GetGrupoDeRestricaoRepository {
  Future<List<RestricaoGrupoDeRestricaoEntity>> call(String search, {String? ultimoGrupoDeRestricaoId});
}
