import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';

abstract class GetGrupoDeRestricaoRepository {
  Future<List<GrupoDeRestricaoEntity>> call(String search);
}
