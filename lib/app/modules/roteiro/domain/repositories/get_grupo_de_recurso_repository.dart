import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_recurso_entity.dart';

abstract class GetGrupoDeRecursoRepository {
  Future<List<GrupoDeRecursoEntity>> call(search);
}
