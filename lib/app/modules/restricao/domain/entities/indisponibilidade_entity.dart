// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';

class IndisponibilidadeEntity {
  final int codigo;
  final DateVO periodoInicial;
  final DateVO periodoFinal;
  final TextVO motivo;
  final TimeVO horarioInicial;
  final TimeVO horarioFinal;

  const IndisponibilidadeEntity({
    required this.codigo,
    required this.periodoInicial,
    required this.periodoFinal,
    required this.motivo,
    required this.horarioInicial,
    required this.horarioFinal,
  });

  factory IndisponibilidadeEntity.empty() {
    return IndisponibilidadeEntity(
      codigo: 0,
      periodoInicial: DateVO(''),
      periodoFinal: DateVO(''),
      motivo: TextVO(''),
      horarioInicial: TimeVO(''),
      horarioFinal: TimeVO(''),
    );
  }

  IndisponibilidadeEntity copyWith({
    int? codigo,
    DateVO? periodoInicial,
    DateVO? periodoFinal,
    TextVO? motivo,
    TimeVO? horarioInicial,
    TimeVO? horarioFinal,
  }) {
    return IndisponibilidadeEntity(
      codigo: codigo ?? this.codigo,
      periodoInicial: periodoInicial ?? this.periodoInicial,
      periodoFinal: periodoFinal ?? this.periodoFinal,
      motivo: motivo ?? this.motivo,
      horarioInicial: horarioInicial ?? this.horarioInicial,
      horarioFinal: horarioFinal ?? this.horarioFinal,
    );
  }

  @override
  bool operator ==(covariant IndisponibilidadeEntity other) {
    if (identical(this, other)) return true;

    return other.codigo == codigo &&
        other.periodoInicial == periodoInicial &&
        other.periodoFinal == periodoFinal &&
        other.motivo == motivo &&
        other.horarioInicial == horarioInicial &&
        other.horarioFinal == horarioFinal;
  }

  @override
  int get hashCode {
    return codigo.hashCode ^
        periodoInicial.hashCode ^
        periodoFinal.hashCode ^
        motivo.hashCode ^
        horarioInicial.hashCode ^
        horarioFinal.hashCode;
  }
}
