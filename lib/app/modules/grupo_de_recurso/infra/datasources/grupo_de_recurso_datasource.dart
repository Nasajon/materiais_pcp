import '../../domain/entities/grupo_de_recurso.dart';

abstract class GrupoDeRecursoDatasource {
  Future<List<GrupoDeRecurso>> getList(String? search);
  Future<GrupoDeRecurso> getItem(String id);
  Future<GrupoDeRecurso> insertItem(GrupoDeRecurso grupoDeRecurso);
  Future<GrupoDeRecurso> updateItem(GrupoDeRecurso grupoDeRecurso);
}
