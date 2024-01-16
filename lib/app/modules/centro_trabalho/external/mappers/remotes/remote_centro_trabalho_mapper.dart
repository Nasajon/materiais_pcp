import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/external/mappers/remotes/remote_turno_trabanho_mappers.dart';

class RemoteCentroTrabalhoMapper {
  const RemoteCentroTrabalhoMapper._();

  static CentroTrabalhoAggregate fromMapToCentroTrabalho(Map<String, dynamic> map) {
    return CentroTrabalhoAggregate(
      id: map['centro_de_trabalho'],
      codigo: CodigoVO.text(map['codigo']),
      nome: TextVO(map['nome']),
      turnos: map.containsKey('turnos')
          ? List.from(map['turnos']).map((map) => RemoteTurnoTrabalhoMapper.fromMapToTurnoTrabalhoEntity(map['turno'])).toList()
          : [],
    );
  }

  static Map<String, dynamic> fromCentroTrabalhoToMap(CentroTrabalhoAggregate centroTrabalho) {
    return {
      'codigo': centroTrabalho.codigo.value.toString(),
      'nome': centroTrabalho.nome.value,
      'turnos': centroTrabalho.turnos.map((turno) => RemoteTurnoTrabalhoMapper.fromTurnoTrabalhoToMap(turno)).toList(),
    };
  }
}
