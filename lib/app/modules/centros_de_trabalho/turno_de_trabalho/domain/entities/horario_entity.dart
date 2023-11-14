import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/types/dias_da_semana_type.dart';

class HorarioEntity {
  final int codigo;
  final List<DiasDaSemanaType> diasDaSemana;
  final TimeVO horarioInicial;
  final TimeVO horarioFinal;
  final TimeVO intervalo;

  const HorarioEntity({
    required this.codigo,
    required this.diasDaSemana,
    required this.horarioInicial,
    required this.horarioFinal,
    required this.intervalo,
  });

  factory HorarioEntity.empty() {
    return HorarioEntity(
      codigo: 0,
      diasDaSemana: [],
      horarioInicial: TimeVO(''),
      horarioFinal: TimeVO(''),
      intervalo: TimeVO(''),
    );
  }

  HorarioEntity copyWith({
    int? codigo,
    List<DiasDaSemanaType>? diasDaSemana,
    TimeVO? horarioInicial,
    TimeVO? horarioFinal,
    TimeVO? intervalo,
  }) {
    return HorarioEntity(
      codigo: codigo ?? this.codigo,
      diasDaSemana: diasDaSemana ?? List.from(this.diasDaSemana),
      horarioInicial: horarioInicial ?? this.horarioInicial,
      horarioFinal: horarioFinal ?? this.horarioFinal,
      intervalo: intervalo ?? this.intervalo,
    );
  }

  @override
  bool operator ==(covariant HorarioEntity other) {
    if (identical(this, other)) return true;

    return other.codigo == codigo &&
        listEquals(other.diasDaSemana, diasDaSemana) &&
        other.horarioInicial == horarioInicial &&
        other.horarioFinal == horarioFinal &&
        other.intervalo == intervalo;
  }

  @override
  int get hashCode {
    return codigo.hashCode ^ diasDaSemana.hashCode ^ horarioInicial.hashCode ^ horarioFinal.hashCode ^ intervalo.hashCode;
  }
}
