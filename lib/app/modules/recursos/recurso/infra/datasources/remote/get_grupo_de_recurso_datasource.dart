import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

abstract class GetGrupoDeRecursoDatasource {
  Future<List<GrupoDeRecurso>> getList();
}
