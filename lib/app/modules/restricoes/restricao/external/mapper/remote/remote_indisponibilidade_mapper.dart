import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/indisponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/enum/horario_enum.dart';

class RemoteIndisponibilidadeMapper {
  const RemoteIndisponibilidadeMapper._();

  static IndisponibilidadeEntity fromMapToIndisponibilidadeEntity(Map<String, dynamic> map) {
    return IndisponibilidadeEntity(
      periodoInicial: DateTime.parse(map['periodo_inicial']),
      periodoFinal: DateTime.parse(map['periodo_final']),
      motivo: map['motivo'],
      horarioInicial: HorarioEnum.selectHorario(map['horario_inicial']),
      HorarioFinal: HorarioEnum.selectHorario(map['Horario_final']),
    );
  }
}
