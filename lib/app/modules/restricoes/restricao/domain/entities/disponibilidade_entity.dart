import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/week_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';

class DisponibilidadeEntity {
  final int codigo;
  final DateVO periodoInicial;
  final DateVO periodoFinal;
  final TimeVO horarioInicial;
  final TimeVO horarioFinal;
  final TimeVO intervaloInicial;
  final TimeVO intervaloFinal;
  final bool diaInteiro;
  final List<WeekEnum> diasDaSemana;

  const DisponibilidadeEntity({
    required this.codigo,
    required this.periodoInicial,
    required this.periodoFinal,
    required this.horarioInicial,
    required this.horarioFinal,
    required this.intervaloInicial,
    required this.intervaloFinal,
    required this.diaInteiro,
    required this.diasDaSemana,
  });

  factory DisponibilidadeEntity.empty() {
    return DisponibilidadeEntity(
      codigo: 0,
      periodoInicial: DateVO(''),
      periodoFinal: DateVO(''),
      horarioInicial: TimeVO(''),
      horarioFinal: TimeVO(''),
      intervaloInicial: TimeVO(''),
      intervaloFinal: TimeVO(''),
      diaInteiro: false,
      diasDaSemana: [],
    );
  }

  DisponibilidadeEntity copyWith({
    int? codigo,
    DateVO? periodoInicial,
    DateVO? periodoFinal,
    TimeVO? horarioInicial,
    TimeVO? horarioFinal,
    TimeVO? intervaloInicial,
    TimeVO? intervaloFinal,
    bool? diaInteiro,
    List<WeekEnum>? diasDaSemana,
  }) {
    return DisponibilidadeEntity(
      codigo: codigo ?? this.codigo,
      periodoInicial: periodoInicial ?? this.periodoInicial,
      periodoFinal: periodoFinal ?? this.periodoFinal,
      horarioInicial: horarioInicial ?? this.horarioInicial,
      horarioFinal: horarioFinal ?? this.horarioFinal,
      intervaloInicial: intervaloInicial ?? this.intervaloInicial,
      intervaloFinal: intervaloFinal ?? this.intervaloFinal,
      diaInteiro: diaInteiro ?? this.diaInteiro,
      diasDaSemana: diasDaSemana ?? List.from(this.diasDaSemana),
    );
  }

  @override
  bool operator ==(covariant DisponibilidadeEntity other) {
    if (identical(this, other)) return true;

    return other.codigo == codigo &&
        other.periodoInicial == periodoInicial &&
        other.periodoFinal == periodoFinal &&
        other.horarioInicial == horarioInicial &&
        other.horarioFinal == horarioFinal &&
        other.intervaloInicial == intervaloInicial &&
        other.intervaloFinal == intervaloFinal &&
        other.diaInteiro == diaInteiro &&
        listEquals(other.diasDaSemana, diasDaSemana);
  }

  @override
  int get hashCode {
    return codigo.hashCode ^
        periodoInicial.hashCode ^
        periodoFinal.hashCode ^
        horarioInicial.hashCode ^
        horarioFinal.hashCode ^
        intervaloInicial.hashCode ^
        intervaloFinal.hashCode ^
        diaInteiro.hashCode ^
        diasDaSemana.hashCode;
  }
}
