// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_recurso_aggregate.dart';

class SequenciamentoAggregate {
  final DateVO tempoInicial;
  final DateVO tempoFinal;
  final List<SequenciamentoRecursoAggregate> sequenciamentoRecursos;

  const SequenciamentoAggregate({
    required this.tempoInicial,
    required this.tempoFinal,
    required this.sequenciamentoRecursos,
  });

  factory SequenciamentoAggregate.empty() {
    return SequenciamentoAggregate(
      tempoInicial: DateVO(''),
      tempoFinal: DateVO(''),
      sequenciamentoRecursos: [],
    );
  }

  SequenciamentoAggregate copyWith({
    DateVO? tempoInicial,
    DateVO? tempoFinal,
    List<SequenciamentoRecursoAggregate>? sequenciamentoRecursos,
  }) {
    return SequenciamentoAggregate(
      tempoInicial: tempoInicial ?? this.tempoInicial,
      tempoFinal: tempoFinal ?? this.tempoFinal,
      sequenciamentoRecursos: sequenciamentoRecursos ?? this.sequenciamentoRecursos,
    );
  }

  @override
  bool operator ==(covariant SequenciamentoAggregate other) {
    if (identical(this, other)) return true;

    return other.tempoInicial == tempoInicial &&
        other.tempoFinal == tempoFinal &&
        listEquals(other.sequenciamentoRecursos, sequenciamentoRecursos);
  }

  @override
  int get hashCode => tempoInicial.hashCode ^ tempoFinal.hashCode ^ sequenciamentoRecursos.hashCode;
}
