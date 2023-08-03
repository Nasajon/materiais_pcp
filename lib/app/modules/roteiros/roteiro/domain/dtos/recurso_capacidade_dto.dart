// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';

class RecursoCapacidadeDTO {
  final TimeVO preparacao;
  final TimeVO execucao;
  final DoubleVO total;
  final DoubleVO minima;
  final DoubleVO maxima;

  const RecursoCapacidadeDTO({
    required this.preparacao,
    required this.execucao,
    required this.total,
    required this.minima,
    required this.maxima,
  });

  RecursoCapacidadeDTO copyWith({
    TimeVO? preparacao,
    TimeVO? execucao,
    DoubleVO? total,
    DoubleVO? minima,
    DoubleVO? maxima,
  }) {
    return RecursoCapacidadeDTO(
      preparacao: preparacao ?? this.preparacao,
      execucao: execucao ?? this.execucao,
      total: total ?? this.total,
      minima: minima ?? this.minima,
      maxima: maxima ?? this.maxima,
    );
  }

  @override
  bool operator ==(covariant RecursoCapacidadeDTO other) {
    if (identical(this, other)) return true;

    return other.preparacao == preparacao &&
        other.execucao == execucao &&
        other.total == total &&
        other.minima == minima &&
        other.maxima == maxima;
  }

  @override
  int get hashCode {
    return preparacao.hashCode ^ execucao.hashCode ^ total.hashCode ^ minima.hashCode ^ maxima.hashCode;
  }
}
