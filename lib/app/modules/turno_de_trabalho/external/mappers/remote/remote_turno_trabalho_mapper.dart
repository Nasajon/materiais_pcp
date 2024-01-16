import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/external/mappers/remote/remote_horario_mapper.dart';

class RemoteTurnoTrabalhoMapper {
  const RemoteTurnoTrabalhoMapper._();

  static TurnoTrabalhoAggregate fromMapToTurnoTrabalho(Map<String, dynamic> map) {
    return TurnoTrabalhoAggregate(
      id: map['turno'],
      codigo: CodigoVO(map['codigo'] is String ? int.parse(map['codigo']) : map['codigo']),
      nome: TextVO(map['nome']),
      horarios:
          map.containsKey('horarios') ? List.from(map['horarios']).map((e) => RemoteHorarioMapper.fromMapToHorarioEntity(e)).toList() : [],
    );
  }

  static Map<String, dynamic> fromTurnoTrabalhoToMap(TurnoTrabalhoAggregate turnoTrabalho, {bool requiredId = false}) {
    final map = {
      'codigo': turnoTrabalho.codigo.toText,
      'nome': turnoTrabalho.nome.value,
      'horarios': turnoTrabalho.horarios.map((horario) => RemoteHorarioMapper.fromHorarioToMap(horario)).toList(),
    };

    if (requiredId) map['turno'] = turnoTrabalho.id;

    return map;
  }
}
