// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';

import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_recurso_evento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/recurso_entity.dart';

class SequenciamentoRecursoAggregate {
  final RecursoEntity recurso;
  final List<SequenciamentoRecursoEventoAggregate> eventos;

  const SequenciamentoRecursoAggregate({
    required this.recurso,
    required this.eventos,
  });

  SequenciamentoRecursoAggregate copyWith({
    RecursoEntity? recurso,
    List<SequenciamentoRecursoEventoAggregate>? eventos,
  }) {
    return SequenciamentoRecursoAggregate(
      recurso: recurso ?? this.recurso,
      eventos: eventos ?? this.eventos,
    );
  }

  @override
  bool operator ==(covariant SequenciamentoRecursoAggregate other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.recurso == recurso && listEquals(other.eventos, eventos);
  }

  @override
  int get hashCode => recurso.hashCode ^ eventos.hashCode;
}
