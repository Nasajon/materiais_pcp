import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';

class RemoteTurnoTrabalhoMapper {
  const RemoteTurnoTrabalhoMapper._();

  static TurnoTrabalhoEntity fromMapToTurnoTrabalhoEntity(Map<String, dynamic> map) {
    return TurnoTrabalhoEntity(
      id: map['turno'],
      codigo: map.containsKey('codigo') ? CodigoVO.text(map['codigo']) : CodigoVO(null),
      nome: map.containsKey('nome') ? map['nome'] : '',
    );
  }

  static Map<String, dynamic> fromTurnoTrabalhoToMap(TurnoTrabalhoEntity turno) {
    return {
      'turno': turno.id,
    };
  }
}
