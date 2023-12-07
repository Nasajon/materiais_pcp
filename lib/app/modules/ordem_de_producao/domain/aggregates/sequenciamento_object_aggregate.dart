// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_evento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/sequenciamento_objetct_entity.dart';

class SequenciamentoObjectAggregate {
  final SequenciamentoObjectEntity eventObject;
  final List<SequenciamentoEventoAggregate> eventos;

  const SequenciamentoObjectAggregate({
    required this.eventObject,
    required this.eventos,
  });

  SequenciamentoObjectAggregate copyWith({
    SequenciamentoObjectEntity? eventObject,
    List<SequenciamentoEventoAggregate>? eventos,
  }) {
    return SequenciamentoObjectAggregate(
      eventObject: eventObject ?? this.eventObject,
      eventos: eventos ?? this.eventos,
    );
  }

  @override
  bool operator ==(covariant SequenciamentoObjectAggregate other) {
    if (identical(this, other)) return true;

    return other.eventObject == eventObject && listEquals(other.eventos, eventos);
  }

  @override
  int get hashCode => eventObject.hashCode ^ eventos.hashCode;
}
