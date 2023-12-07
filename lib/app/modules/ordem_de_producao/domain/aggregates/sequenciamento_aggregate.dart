// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_object_aggregate.dart';

class SequenciamentoAggregate {
  final DateVO tempoInicial;
  final DateVO tempoFinal;
  final List<SequenciamentoObjectAggregate> sequenciamentoRecursos;
  final List<SequenciamentoObjectAggregate> sequenciamentoRestricoes;

  const SequenciamentoAggregate({
    required this.tempoInicial,
    required this.tempoFinal,
    required this.sequenciamentoRecursos,
    required this.sequenciamentoRestricoes,
  });

  factory SequenciamentoAggregate.empty() {
    return SequenciamentoAggregate(
      tempoInicial: DateVO(''),
      tempoFinal: DateVO(''),
      sequenciamentoRecursos: [],
      sequenciamentoRestricoes: [],
    );
  }

  SequenciamentoAggregate copyWith({
    DateVO? tempoInicial,
    DateVO? tempoFinal,
    List<SequenciamentoObjectAggregate>? sequenciamentoRecursos,
    List<SequenciamentoObjectAggregate>? sequenciamentoRestricoes,
  }) {
    return SequenciamentoAggregate(
      tempoInicial: tempoInicial ?? this.tempoInicial,
      tempoFinal: tempoFinal ?? this.tempoFinal,
      sequenciamentoRecursos: sequenciamentoRecursos ?? this.sequenciamentoRecursos,
      sequenciamentoRestricoes: sequenciamentoRestricoes ?? this.sequenciamentoRestricoes,
    );
  }

  @override
  bool operator ==(covariant SequenciamentoAggregate other) {
    if (identical(this, other)) return true;

    return other.tempoInicial == tempoInicial &&
        other.tempoFinal == tempoFinal &&
        listEquals(other.sequenciamentoRecursos, sequenciamentoRecursos) &&
        listEquals(other.sequenciamentoRestricoes, sequenciamentoRestricoes);
  }

  @override
  int get hashCode {
    return tempoInicial.hashCode ^ tempoFinal.hashCode ^ sequenciamentoRecursos.hashCode ^ sequenciamentoRestricoes.hashCode;
  }
}
