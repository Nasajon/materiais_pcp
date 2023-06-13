import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/enum/horario_enum.dart';

class IndisponibilidadeEntity {
  final int codigo;
  final DateVO periodoInicial;
  final DateVO periodoFinal;
  final TextVO motivo;
  final HorarioEnum? horarioInicial;
  final HorarioEnum? horarioFinal;

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
      horarioInicial: null,
      horarioFinal: null,
    );
  }

  IndisponibilidadeEntity copyWith({
    int? codigo,
    DateVO? periodoInicial,
    DateVO? periodoFinal,
    TextVO? motivo,
    HorarioEnum? horarioInicial,
    HorarioEnum? horarioFinal,
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
}
