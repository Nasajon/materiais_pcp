import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/grupo_de_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_recurso_capacidade_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_recurso_mapper.dart';

class RemoteGrupoDeRecursoMapper {
  const RemoteGrupoDeRecursoMapper._();

  static GrupoDeRecursoEntity fromMapToGrupoDeRecursoEntity(Map<String, dynamic> map) {
    return GrupoDeRecursoEntity(
      id: map['grupo_de_recurso'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }

  static GrupoDeRecursoAggregate fromMapToGrupoDeRecursoAggragate(Map<String, dynamic> map) {
    return GrupoDeRecursoAggregate(
      grupo: fromMapToGrupoDeRecursoEntity(map['grupo_de_recurso']),
      capacidade: RemoteRecursoCapacidadeMapper.fromMapToRecursoCapacidadeDTO(map),
      recursos: List.from(map['recursos']).map((map) => RemoteRecursoMapper.fromMapToRecursoAggregate(map)).toList(),
    );
  }

  static Map<String, dynamic> fromGrupoDeRecursoToMap(GrupoDeRecursoAggregate grupoDeRecurso) {
    return {
      'grupo_de_recurso': grupoDeRecurso.grupo.id,
      ...RemoteRecursoCapacidadeMapper.fromRecursoCapacidadeToMap(grupoDeRecurso.capacidade),
      'recursos': grupoDeRecurso.recursos.map((recurso) => RemoteRecursoMapper.fromRecursoAggregateToMap(recurso)).toList(),
    };
  }
}
