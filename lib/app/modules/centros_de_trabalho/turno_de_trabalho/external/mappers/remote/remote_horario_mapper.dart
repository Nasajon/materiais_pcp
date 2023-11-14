import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/entities/horario_entity.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/types/dias_da_semana_type.dart';

class RemoteHorarioMapper {
  const RemoteHorarioMapper._();

  static HorarioEntity fromMapToHorarioEntity(Map<String, dynamic> map) {
    final List<DiasDaSemanaType> diasDaSemana = [];

    if (map['domingo']) diasDaSemana.add(DiasDaSemanaType.sunday);
    if (map['segunda']) diasDaSemana.add(DiasDaSemanaType.monday);
    if (map['terca']) diasDaSemana.add(DiasDaSemanaType.tuesday);
    if (map['quarta']) diasDaSemana.add(DiasDaSemanaType.wednesday);
    if (map['quinta']) diasDaSemana.add(DiasDaSemanaType.thursday);
    if (map['sexta']) diasDaSemana.add(DiasDaSemanaType.friday);
    if (map['sabado']) diasDaSemana.add(DiasDaSemanaType.saturday);

    return HorarioEntity(
      codigo: 0,
      diasDaSemana: diasDaSemana,
      horarioInicial: TimeVO(map['inicio']),
      horarioFinal: TimeVO(map['fim']),
      intervalo: TimeVO(map['intervalo']),
    );
  }

  static Map<String, dynamic> fromHorarioToMap(HorarioEntity horario) {
    return {
      'inicio': horario.horarioInicial.timeFormat(shouldAddSeconds: true),
      'fim': horario.horarioFinal.timeFormat(shouldAddSeconds: true),
      'intervalo': horario.intervalo.timeFormat(shouldAddSeconds: true),
      'domingo': horario.diasDaSemana.contains(DiasDaSemanaType.sunday),
      'segunda': horario.diasDaSemana.contains(DiasDaSemanaType.monday),
      'terca': horario.diasDaSemana.contains(DiasDaSemanaType.tuesday),
      'quarta': horario.diasDaSemana.contains(DiasDaSemanaType.wednesday),
      'quinta': horario.diasDaSemana.contains(DiasDaSemanaType.thursday),
      'sexta': horario.diasDaSemana.contains(DiasDaSemanaType.friday),
      'sabado': horario.diasDaSemana.contains(DiasDaSemanaType.saturday),
    };
  }

  static List<HorarioEntity> setarIndexParaOsHorarios(List<HorarioEntity> horarios) {
    for (var i = 1; i <= horarios.length; i++) {
      horarios.setAll(i - 1, [horarios[i - 1].copyWith(codigo: i)]);
    }

    return horarios;
  }
}
