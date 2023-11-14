import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/recurso_capacidade_dto.dart';

class RecursoAggregate {
  final String id;
  final String codigo;
  final String nome;
  final RecursoCapacidadeDTO capacidade;
  final List<GrupoDeRestricaoAggregate> grupoDeRestricoes;

  const RecursoAggregate({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.capacidade,
    required this.grupoDeRestricoes,
  });

  factory RecursoAggregate.empty() {
    return RecursoAggregate(
      id: '',
      codigo: '',
      nome: '',
      capacidade: RecursoCapacidadeDTO.empty(),
      grupoDeRestricoes: [],
    );
  }

  RecursoAggregate copyWith({
    String? id,
    String? codigo,
    String? nome,
    RecursoCapacidadeDTO? capacidade,
    List<GrupoDeRestricaoAggregate>? grupoDeRestricoes,
  }) {
    return RecursoAggregate(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      capacidade: capacidade ?? this.capacidade,
      grupoDeRestricoes: grupoDeRestricoes ?? List.from(this.grupoDeRestricoes),
    );
  }

  @override
  bool operator ==(covariant RecursoAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.codigo == codigo &&
        other.nome == nome &&
        other.capacidade == capacidade &&
        listEquals(other.grupoDeRestricoes, grupoDeRestricoes);
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ capacidade.hashCode ^ grupoDeRestricoes.hashCode;
  }

  bool get isValid => id.isNotEmpty && capacidade.isValid;
}
