import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_recurso_entity.dart';

abstract class RemoteGetGrupoDeRecursoDatasource {
  Future<List<GrupoDeRecursoEntity>> call(String search);
}
