import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_grupo_de_recurso_entity.dart';

abstract class GetChaoDeFabricaGrupoDeRecursoRepository {
  Future<List<ChaoDeFabricaGrupoDeRecursoEntity>> call({String? ultimoGrupoDeRecursoId});
}
