import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_recurso_entity.dart';

class RemoteGrupoDeRecursoMapper {
  const RemoteGrupoDeRecursoMapper._();

  static GrupoDeRecursoEntity fromMapToGrupoDeRecursoEntity(Map<String, dynamic> map) {
    return GrupoDeRecursoEntity(
      id: map['grupo_de_recurso'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }
}
