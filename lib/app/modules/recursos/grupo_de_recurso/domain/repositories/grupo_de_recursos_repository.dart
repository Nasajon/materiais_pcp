import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

abstract class GrupoDeRecursosRepository {
  Future<List<GrupoDeRecurso>> getList(String? search);
  Future<GrupoDeRecurso> getItem(String id);
  Future<GrupoDeRecurso> insertItem(GrupoDeRecurso grupoDeRecurso);
  Future<GrupoDeRecurso> updateItem(GrupoDeRecurso grupoDeRecurso);
}
