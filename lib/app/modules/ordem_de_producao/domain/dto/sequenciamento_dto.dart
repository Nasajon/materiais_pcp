import 'package:flutter/foundation.dart';

class SequenciamentoDTO {
  final List<String> ordensIds;
  final List<String> recursosIds;
  final List<String> restricoesIds;

  const SequenciamentoDTO({
    required this.ordensIds,
    required this.recursosIds,
    required this.restricoesIds,
  });

  SequenciamentoDTO copyWith({
    List<String>? ordensIds,
    List<String>? recursosIds,
    List<String>? restricoesIds,
  }) {
    return SequenciamentoDTO(
      ordensIds: ordensIds ?? this.ordensIds,
      recursosIds: recursosIds ?? this.recursosIds,
      restricoesIds: restricoesIds ?? this.restricoesIds,
    );
  }

  @override
  bool operator ==(covariant SequenciamentoDTO other) {
    if (identical(this, other)) return true;

    return listEquals(other.ordensIds, ordensIds) &&
        listEquals(other.recursosIds, recursosIds) &&
        listEquals(other.restricoesIds, restricoesIds);
  }

  @override
  int get hashCode => ordensIds.hashCode ^ recursosIds.hashCode ^ restricoesIds.hashCode;
}
