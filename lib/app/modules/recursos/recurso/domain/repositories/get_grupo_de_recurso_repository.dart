import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

abstract class GetGrupoDeRecursoRepository {
  Future<List<GrupoDeRecurso>> getList({
    required String search,
    String? ultimoGrupoDeRecursoId,
  });
}
