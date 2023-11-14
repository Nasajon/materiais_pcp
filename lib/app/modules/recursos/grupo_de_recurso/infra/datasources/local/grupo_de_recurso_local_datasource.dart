import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

abstract class GrupoDeRecursoLocalDatasource {
  Future<List<GrupoDeRecurso>> getList(String? search);
  Future<void> insertList(List<GrupoDeRecurso> gruposDeRecurso);
  Future<void> insertItem(GrupoDeRecurso grupoDeRecurso);
  Future<void> clearList();
}
