// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';

class RecursoCapacidadeDTO {
  final TimeVO preparacao;
  final TimeVO execucao;
  final DoubleVO capacidadeTotal;
  final DoubleVO minima;
  final DoubleVO maxima;

  const RecursoCapacidadeDTO({
    required this.preparacao,
    required this.execucao,
    required this.capacidadeTotal,
    required this.minima,
    required this.maxima,
  });

  factory RecursoCapacidadeDTO.empty() {
    return RecursoCapacidadeDTO(
      preparacao: TimeVO(''),
      execucao: TimeVO(''),
      capacidadeTotal: DoubleVO(null),
      minima: DoubleVO(null),
      maxima: DoubleVO(null),
    );
  }

  RecursoCapacidadeDTO copyWith({
    TimeVO? preparacao,
    TimeVO? execucao,
    DoubleVO? capacidadeTotal,
    DoubleVO? minima,
    DoubleVO? maxima,
  }) {
    return RecursoCapacidadeDTO(
      preparacao: preparacao ?? this.preparacao,
      execucao: execucao ?? this.execucao,
      capacidadeTotal: capacidadeTotal ?? this.capacidadeTotal,
      minima: minima ?? this.minima,
      maxima: maxima ?? this.maxima,
    );
  }

  @override
  bool operator ==(covariant RecursoCapacidadeDTO other) {
    if (identical(this, other)) return true;

    return other.preparacao == preparacao &&
        other.execucao == execucao &&
        other.capacidadeTotal == capacidadeTotal &&
        other.minima == minima &&
        other.maxima == maxima;
  }

  @override
  int get hashCode {
    return preparacao.hashCode ^ execucao.hashCode ^ capacidadeTotal.hashCode ^ minima.hashCode ^ maxima.hashCode;
  }

  bool get isValid =>
      preparacao.isValid && //
      execucao.isValid &&
      capacidadeTotal.isValid &&
      minima.isValid &&
      maxima.isValid;
}
