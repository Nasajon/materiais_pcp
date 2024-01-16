import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_grupo_de_recurso.dart';

abstract class GetGrupoDeRecursoRepository {
  Future<List<RecursoGrupoDeRecurso>> getList({
    required String search,
    String? ultimoGrupoDeRecursoId,
  });
}
