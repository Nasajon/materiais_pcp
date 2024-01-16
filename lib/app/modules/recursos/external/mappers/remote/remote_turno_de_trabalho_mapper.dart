import 'package:pcp_flutter/app/modules/recursos/domain/entities/turno_de_trabalho_entity.dart';

class RemoteTurnoDeTrabalhoMapper {
  const RemoteTurnoDeTrabalhoMapper._();

  static TurnoDeTrabalhoEntity fromMapToTurnoTrabalho(Map<String, dynamic> map) {
    return TurnoDeTrabalhoEntity(
      turnoRecurso: null,
      id: map['turno'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }

  static TurnoDeTrabalhoEntity fromMapToRecursoTurnoTrabalho(Map<String, dynamic> map) {
    return TurnoDeTrabalhoEntity(
      turnoRecurso: map['turno_recurso'],
      id: map['turno']['turno'],
      codigo: map['turno']['codigo'],
      nome: map['turno']['nome'],
    );
  }

  static Map<String, dynamic> fromTurnoTrabalhoToMap(TurnoDeTrabalhoEntity turnoTrabalho) {
    final map = <String, dynamic>{
      'turno': turnoTrabalho.id,
    };

    if (turnoTrabalho.turnoRecurso != null && turnoTrabalho.turnoRecurso!.isNotEmpty) {
      map['turno_recurso'] = turnoTrabalho.turnoRecurso;
    }

    return map;
  }
}
