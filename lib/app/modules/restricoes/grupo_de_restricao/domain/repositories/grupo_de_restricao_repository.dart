import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';

abstract class GrupoDeRestricaoRepository {
  Future<List<GrupoDeRestricaoEntity>> getGrupoDeRestricaoRecente();
  Future<List<GrupoDeRestricaoEntity>> getList(String? search);
  Future<GrupoDeRestricaoEntity> getItem(String id);
  Future<GrupoDeRestricaoEntity> insertItem(GrupoDeRestricaoEntity grupoDeRestricao);
  Future<GrupoDeRestricaoEntity> updateItem(GrupoDeRestricaoEntity grupoDeRestricao);
  Future<bool> deletarItem(String id);
}
