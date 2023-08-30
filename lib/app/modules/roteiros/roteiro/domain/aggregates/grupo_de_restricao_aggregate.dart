// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/restricao_capacidade_dto.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/enums/operacao_enum.dart';

class GrupoDeRestricaoAggregate {
  final GrupoDeRestricaoEntity grupo;
  final UnidadeEntity unidade;
  final RestricaoCapacidadeDTO capacidade;
  final QuandoEnum? quando;
  final List<RestricaoAggregate> restricoes;

  const GrupoDeRestricaoAggregate({
    required this.grupo,
    required this.unidade,
    required this.capacidade,
    required this.quando,
    required this.restricoes,
  });

  factory GrupoDeRestricaoAggregate.empty() {
    return GrupoDeRestricaoAggregate(
      grupo: GrupoDeRestricaoEntity.empty(),
      unidade: UnidadeEntity.empty(),
      capacidade: RestricaoCapacidadeDTO.empty(),
      quando: null,
      restricoes: [],
    );
  }

  GrupoDeRestricaoAggregate copyWith({
    GrupoDeRestricaoEntity? grupo,
    UnidadeEntity? unidade,
    RestricaoCapacidadeDTO? capacidade,
    QuandoEnum? quando,
    List<RestricaoAggregate>? restricoes,
  }) {
    return GrupoDeRestricaoAggregate(
      grupo: grupo ?? this.grupo,
      unidade: unidade ?? this.unidade,
      capacidade: capacidade ?? this.capacidade,
      quando: quando ?? this.quando,
      restricoes: restricoes ?? List.from(this.restricoes),
    );
  }

  @override
  bool operator ==(covariant GrupoDeRestricaoAggregate other) {
    if (identical(this, other)) return true;

    return other.grupo == grupo &&
        other.unidade == unidade &&
        other.capacidade == capacidade &&
        other.quando == quando &&
        listEquals(other.restricoes, restricoes);
  }

  @override
  int get hashCode {
    return grupo.hashCode ^ unidade.hashCode ^ capacidade.hashCode ^ quando.hashCode ^ restricoes.hashCode;
  }

  bool get isValid => grupo.id.isNotEmpty && capacidade.isValid;
}
