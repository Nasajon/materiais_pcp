// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/restricao_capacidade_dto.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';

class GrupoDeRestricaoAggregate {
  final GrupoDeRestricaoEntity grupoDeRestricao;
  final RestricaoCapacidadeDTO restricaoCapacidade;
  final List<RestricaoAggregate> restricoes;

  const GrupoDeRestricaoAggregate({
    required this.grupoDeRestricao,
    required this.restricaoCapacidade,
    required this.restricoes,
  });

  GrupoDeRestricaoAggregate copyWith({
    GrupoDeRestricaoEntity? grupoDeRestricao,
    RestricaoCapacidadeDTO? restricaoCapacidade,
    List<RestricaoAggregate>? restricoes,
  }) {
    return GrupoDeRestricaoAggregate(
      grupoDeRestricao: grupoDeRestricao ?? this.grupoDeRestricao,
      restricaoCapacidade: restricaoCapacidade ?? this.restricaoCapacidade,
      restricoes: restricoes ?? List.from(this.restricoes),
    );
  }

  @override
  bool operator ==(covariant GrupoDeRestricaoAggregate other) {
    if (identical(this, other)) return true;

    return other.grupoDeRestricao == grupoDeRestricao &&
        other.restricaoCapacidade == restricaoCapacidade &&
        listEquals(other.restricoes, restricoes);
  }

  @override
  int get hashCode => grupoDeRestricao.hashCode ^ restricaoCapacidade.hashCode ^ restricoes.hashCode;

  bool get isValid => grupoDeRestricao.id.isNotEmpty && restricaoCapacidade.isValid;
}
