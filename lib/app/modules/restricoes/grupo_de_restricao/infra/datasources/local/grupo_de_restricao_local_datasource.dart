import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';

abstract class GrupoDeRestricaoLocalDatasource {
  Future<List<GrupoDeRestricaoEntity>> getList(String? search);
  Future<void> insertList(List<GrupoDeRestricaoEntity> gruposDeRestricao);
  Future<void> insertItem(GrupoDeRestricaoEntity grupoDeRestricao);
  Future<void> clearList();
}
