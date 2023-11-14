import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/recurso_capacidade_dto.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_recurso_entity.dart';

class GrupoDeRecursoAggregate {
  final GrupoDeRecursoEntity grupo;
  final RecursoCapacidadeDTO capacidade;
  final List<RecursoAggregate> recursos;

  const GrupoDeRecursoAggregate({
    required this.grupo,
    required this.capacidade,
    required this.recursos,
  });

  factory GrupoDeRecursoAggregate.empty() {
    return GrupoDeRecursoAggregate(
      grupo: GrupoDeRecursoEntity.empty(),
      capacidade: RecursoCapacidadeDTO.empty(),
      recursos: [],
    );
  }

  GrupoDeRecursoAggregate copyWith({
    GrupoDeRecursoEntity? grupo,
    RecursoCapacidadeDTO? capacidade,
    List<RecursoAggregate>? recursos,
  }) {
    return GrupoDeRecursoAggregate(
      grupo: grupo ?? this.grupo,
      capacidade: capacidade ?? this.capacidade,
      recursos: recursos ?? List.from(this.recursos),
    );
  }

  @override
  bool operator ==(covariant GrupoDeRecursoAggregate other) {
    if (identical(this, other)) return true;

    return other.grupo == grupo && other.capacidade == capacidade && listEquals(other.recursos, recursos);
  }

  @override
  int get hashCode => grupo.hashCode ^ capacidade.hashCode ^ recursos.hashCode;

  bool get isValid => grupo.id.isNotEmpty && capacidade.isValid && recursos.isNotEmpty;
}
