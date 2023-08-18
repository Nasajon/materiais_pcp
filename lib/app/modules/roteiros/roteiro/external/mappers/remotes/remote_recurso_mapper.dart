import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/recurso_capacidade_dto.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_grupo_de_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_recurso_capacidade_mapper.dart';

class RemoteRecursoMapper {
  const RemoteRecursoMapper._();

  static RecursoAggregate fromMapToRecurso(Map<String, dynamic> map) {
    return RecursoAggregate(
      id: map['recurso'],
      codigo: map['codigo'],
      nome: map['nome'],
      capacidade: RecursoCapacidadeDTO.empty(),
      grupoDeRestricoes: [],
    );
  }

  static RecursoAggregate fromMapToRecursoAggregate(Map<String, dynamic> map) {
    return RecursoAggregate(
      id: map['recurso']['recurso'],
      codigo: map['recurso']['codigo'],
      nome: map['recurso']['nome'],
      capacidade: RemoteRecursoCapacidadeMapper.fromMapToRecursoCapacidadeDTO(map),
      grupoDeRestricoes:
          List.from(map['grupos_restricoes']).map((map) => RemoteGrupoDeRestricaoMapper.fromMapToGrupoDeRestricaoAggregate(map)).toList(),
    );
  }

  static Map<String, dynamic> fromRecursoAggregateToMap(RecursoAggregate recursoAggregate) {
    return {
      'recurso': recursoAggregate.id,
      ...RemoteRecursoCapacidadeMapper.fromRecursoCapacidadeToMap(recursoAggregate.capacidade),
      'grupos_restricoes': recursoAggregate.grupoDeRestricoes
          .map((grupoDeRestricao) => RemoteGrupoDeRestricaoMapper.fromGrupoDeRestricaoAggregateToMap(grupoDeRestricao))
          .toList(),
    };
  }
}
