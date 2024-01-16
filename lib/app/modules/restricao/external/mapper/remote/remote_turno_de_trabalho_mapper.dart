import 'package:pcp_flutter/app/modules/restricao/domain/entities/turno_de_trabalho_entity.dart';

class RemoteTurnoDeTrabalhoMapper {
  const RemoteTurnoDeTrabalhoMapper._();

  static TurnoDeTrabalhoEntity fromMapToTurnoTrabalho(Map<String, dynamic> map) {
    return TurnoDeTrabalhoEntity(
      turnoRestricao: null,
      id: map['turno'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }

  static TurnoDeTrabalhoEntity fromMapToRestricaoTurnoTrabalho(Map<String, dynamic> map) {
    return TurnoDeTrabalhoEntity(
      turnoRestricao: map['turno_restricao'],
      id: map['turno']['turno'],
      codigo: map['turno']['codigo'],
      nome: map['turno']['nome'],
    );
  }

  static Map<String, dynamic> fromTurnoTrabalhoToMap(TurnoDeTrabalhoEntity turnoTrabalho) {
    final map = <String, dynamic>{
      'turno': turnoTrabalho.id,
    };

    if (turnoTrabalho.turnoRestricao != null && turnoTrabalho.turnoRestricao!.isNotEmpty) {
      map['turno_restricao'] = turnoTrabalho.turnoRestricao;
    }

    return map;
  }
}
