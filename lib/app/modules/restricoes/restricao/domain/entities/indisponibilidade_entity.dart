// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/enum/horario_enum.dart';

class IndisponibilidadeEntity {
  final DateTime periodoInicial;
  final DateTime periodoFinal;
  final String motivo;
  final HorarioEnum horarioInicial;
  final HorarioEnum HorarioFinal;

  const IndisponibilidadeEntity({
    required this.periodoInicial,
    required this.periodoFinal,
    required this.motivo,
    required this.horarioInicial,
    required this.HorarioFinal,
  });

  IndisponibilidadeEntity copyWith({
    DateTime? periodoInicial,
    DateTime? periodoFinal,
    String? motivo,
    HorarioEnum? horarioInicial,
    HorarioEnum? HorarioFinal,
  }) {
    return IndisponibilidadeEntity(
      periodoInicial: periodoInicial ?? this.periodoInicial,
      periodoFinal: periodoFinal ?? this.periodoFinal,
      motivo: motivo ?? this.motivo,
      horarioInicial: horarioInicial ?? this.horarioInicial,
      HorarioFinal: HorarioFinal ?? this.HorarioFinal,
    );
  }
}
