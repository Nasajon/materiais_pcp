import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';

abstract class GrupoDeRecursosRepository {
  Future<List<GrupoDeRecurso>> getList(String? search);
  Future<List<GrupoDeRecurso>> getGrupoDeRecursoRecente();
  Future<GrupoDeRecurso> getItem(String id);
  Future<GrupoDeRecurso> insertItem(GrupoDeRecurso grupoDeRecurso);
  Future<GrupoDeRecurso> updateItem(GrupoDeRecurso grupoDeRecurso);
  Future<bool> deleteItem(String id);
}
