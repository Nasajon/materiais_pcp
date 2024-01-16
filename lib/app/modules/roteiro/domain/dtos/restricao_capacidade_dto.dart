// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/unidade_entity.dart';

class RestricaoCapacidadeDTO {
  final UnidadeEntity unidade;
  final DoubleVO capacidade;
  final DoubleVO usar;
  final TimeVO tempo;

  const RestricaoCapacidadeDTO({
    required this.unidade,
    required this.capacidade,
    required this.usar,
    required this.tempo,
  });

  factory RestricaoCapacidadeDTO.empty() {
    return RestricaoCapacidadeDTO(
      unidade: UnidadeEntity.empty(),
      capacidade: DoubleVO(null),
      usar: DoubleVO(null),
      tempo: TimeVO(''),
    );
  }

  RestricaoCapacidadeDTO copyWith({
    UnidadeEntity? unidade,
    DoubleVO? capacidade,
    DoubleVO? usar,
    TimeVO? tempo,
  }) {
    return RestricaoCapacidadeDTO(
      unidade: unidade ?? this.unidade,
      capacidade: capacidade ?? this.capacidade,
      usar: usar ?? this.usar,
      tempo: tempo ?? this.tempo,
    );
  }

  @override
  bool operator ==(covariant RestricaoCapacidadeDTO other) {
    if (identical(this, other)) return true;

    return other.unidade == unidade && other.capacidade == capacidade && other.usar == usar && other.tempo == tempo;
  }

  @override
  int get hashCode {
    return unidade.hashCode ^ capacidade.hashCode ^ usar.hashCode ^ tempo.hashCode;
  }

  bool get isValid =>
      unidade.id.isNotEmpty && //
      capacidade.isValid &&
      usar.isValid &&
      tempo.isValid;
}
