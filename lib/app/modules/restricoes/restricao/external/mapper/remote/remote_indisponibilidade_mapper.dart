import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/indisponibilidade_entity.dart';

class RemoteIndisponibilidadeMapper {
  const RemoteIndisponibilidadeMapper._();

  static IndisponibilidadeEntity fromMapToIndisponibilidadeEntity(Map<String, dynamic> map) {
    return IndisponibilidadeEntity(
      codigo: 0,
      periodoInicial: DateVO.date(DateTime.parse(map['data_inicial'])),
      periodoFinal: DateVO.date(DateTime.parse(map['data_final'])),
      motivo: TextVO(map['motivo']),
      horarioInicial: TimeVO(map['horario_inicial']),
      horarioFinal: TimeVO(map['horario_final']),
    );
  }

  static Map<String, dynamic> fromIndisponibilidadeEntityToMap(IndisponibilidadeEntity indisponibilidade) {
    return {
      'data_inicial': indisponibilidade.periodoInicial.dateFormat(format: 'yyyy-MM-dd'),
      'data_final': indisponibilidade.periodoFinal.dateFormat(format: 'yyyy-MM-dd'),
      'motivo': indisponibilidade.motivo.value,
      'horario_inicial': indisponibilidade.horarioInicial.timeFormat(shouldAddSeconds: true),
      'horario_final': indisponibilidade.horarioFinal.timeFormat(shouldAddSeconds: true),
    };
  }

  static List<IndisponibilidadeEntity> setarIndexParaOsIndisponibilidades(List<IndisponibilidadeEntity> indisponibilidades) {
    for (var i = 1; i <= indisponibilidades.length; i++) {
      indisponibilidades.setAll(i - 1, [indisponibilidades[i - 1].copyWith(codigo: i)]);
    }

    return indisponibilidades;
  }
}
