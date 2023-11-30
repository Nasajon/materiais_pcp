import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/grupo_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_recurso_mapper.dart';

class RemoteGrupoDeRecursoMapper {
  const RemoteGrupoDeRecursoMapper._();

  static GrupoDeRecursoEntity fromMapToGrupoDeRecursoEntity(Map<String, dynamic> map) {
    return GrupoDeRecursoEntity(
      id: map['grupo_de_recurso']['grupo_de_recurso'],
      codigo: map['grupo_de_recurso']['codigo'],
      nome: map['grupo_de_recurso']['nome'],
      recursos: List.from(map['recursos']).map((map) => RemoteRecursoMapper.fromMapToRecurso(map)).toList(),
    );
  }
}
