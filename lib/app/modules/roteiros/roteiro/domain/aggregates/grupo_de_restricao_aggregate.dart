import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';

class GrupoDeRestricaoAggregate {
  final GrupoDeRestricaoEntity grupoDeRestricao;
  final UnidadeEntity unidade;
  final DoubleVO capacidade;
  final DoubleVO usar;
  final List<RestricaoEntity> restricoes;

  const GrupoDeRestricaoAggregate({
    required this.grupoDeRestricao,
    required this.unidade,
    required this.capacidade,
    required this.usar,
    required this.restricoes,
  });

  GrupoDeRestricaoAggregate copyWith({
    GrupoDeRestricaoEntity? grupoDeRestricao,
    UnidadeEntity? unidade,
    DoubleVO? capacidade,
    DoubleVO? usar,
    List<RestricaoEntity>? restricoes,
  }) {
    return GrupoDeRestricaoAggregate(
      grupoDeRestricao: grupoDeRestricao ?? this.grupoDeRestricao,
      unidade: unidade ?? this.unidade,
      capacidade: capacidade ?? this.capacidade,
      usar: usar ?? this.usar,
      restricoes: restricoes ?? this.restricoes,
    );
  }

  @override
  bool operator ==(covariant GrupoDeRestricaoAggregate other) {
    if (identical(this, other)) return true;

    return other.grupoDeRestricao == grupoDeRestricao &&
        other.unidade == unidade &&
        other.capacidade == capacidade &&
        other.usar == usar &&
        listEquals(other.restricoes, restricoes);
  }

  @override
  int get hashCode {
    return grupoDeRestricao.hashCode ^ unidade.hashCode ^ capacidade.hashCode ^ usar.hashCode ^ restricoes.hashCode;
  }
}
