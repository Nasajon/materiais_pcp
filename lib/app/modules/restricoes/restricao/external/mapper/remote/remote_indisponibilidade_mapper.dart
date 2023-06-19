import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/indisponibilidade_entity.dart';

class RemoteIndisponibilidadeMapper {
  const RemoteIndisponibilidadeMapper._();

  static IndisponibilidadeEntity fromMapToIndisponibilidadeEntity(Map<String, dynamic> map) {
    return IndisponibilidadeEntity(
      codigo: 0,
      periodoInicial: DateVO(map['periodo_inicial']),
      periodoFinal: DateVO(map['periodo_final']),
      motivo: map['motivo'],
      horarioInicial: TimeVO(map['horario_inicial']),
      horarioFinal: TimeVO(map['Horario_final']),
    );
  }
}
