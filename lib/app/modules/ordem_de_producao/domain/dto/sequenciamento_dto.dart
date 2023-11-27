import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SequenciamentoDTO {
  final List<String> ordensIds;
  final List<String> recursosIds;

  const SequenciamentoDTO({
    required this.ordensIds,
    required this.recursosIds,
  });

  SequenciamentoDTO copyWith({
    List<String>? ordensIds,
    List<String>? recursosIds,
  }) {
    return SequenciamentoDTO(
      ordensIds: ordensIds ?? this.ordensIds,
      recursosIds: recursosIds ?? this.recursosIds,
    );
  }

  @override
  bool operator ==(covariant SequenciamentoDTO other) {
    if (identical(this, other)) return true;

    return listEquals(other.ordensIds, ordensIds) && listEquals(other.recursosIds, recursosIds);
  }

  @override
  int get hashCode => ordensIds.hashCode ^ recursosIds.hashCode;
}
