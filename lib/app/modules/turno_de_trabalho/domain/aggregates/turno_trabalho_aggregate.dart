import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/entities/horario_entity.dart';

class TurnoTrabalhoAggregate {
  final String id;
  final CodigoVO codigo;
  final TextVO nome;
  final List<HorarioEntity> horarios;

  const TurnoTrabalhoAggregate({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.horarios,
  });

  factory TurnoTrabalhoAggregate.empty() {
    return TurnoTrabalhoAggregate(
      id: '',
      codigo: CodigoVO(null),
      nome: TextVO(''),
      horarios: [],
    );
  }

  TurnoTrabalhoAggregate copyWith({
    String? id,
    CodigoVO? codigo,
    TextVO? nome,
    List<HorarioEntity>? horarios,
  }) {
    return TurnoTrabalhoAggregate(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      horarios: horarios ?? List.from(this.horarios),
    );
  }

  @override
  bool operator ==(covariant TurnoTrabalhoAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && listEquals(other.horarios, horarios);
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ horarios.hashCode;
  }

  bool get isDadosGeraisValid => codigo.isValid && nome.isValid;

  bool get isHorarioValid => horarios.isNotEmpty;

  bool get isValid => isDadosGeraisValid && isHorarioValid;
}
