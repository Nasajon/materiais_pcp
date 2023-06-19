import 'package:pcp_flutter/app/core/modules/domain/enums/week_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/disponibilidade_entity.dart';

class RemoteDisponibilidadeMapper {
  const RemoteDisponibilidadeMapper._();

  static DisponibilidadeEntity fromMapToDisponibilidadeEntity(Map<String, dynamic> map) {
    return DisponibilidadeEntity(
      codigo: 0,
      periodoInicial: DateVO(map['periodo_inicial']),
      periodoFinal: DateVO(map['periodo_final']),
      horarioInicial: TimeVO(map['horario_inicial']),
      horarioFinal: TimeVO(map['Horario_final']),
      intervaloInicial: TimeVO(map['intervalo_inicial']),
      intervaloFinal: TimeVO(map['intervalo_final']),
      diaInteiro: map['dia_inteiro'],
      diasDaSemana: map['dia_da_semana'].map((e) => WeekEnum.selectDayOfWeek(e)).toList(),
    );
  }
}
