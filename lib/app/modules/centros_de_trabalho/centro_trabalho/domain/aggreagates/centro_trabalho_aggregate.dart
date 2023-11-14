// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/entities/turno_trabalho_entity.dart';

class CentroTrabalhoAggregate {
  final String id;
  final CodigoVO codigo;
  final TextVO nome;
  final List<TurnoTrabalhoEntity> turnos;

  const CentroTrabalhoAggregate({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.turnos,
  });

  CentroTrabalhoAggregate copyWith({
    String? id,
    CodigoVO? codigo,
    TextVO? nome,
    List<TurnoTrabalhoEntity>? turnos,
  }) {
    return CentroTrabalhoAggregate(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      turnos: turnos ?? List.from(this.turnos),
    );
  }

  factory CentroTrabalhoAggregate.empty() {
    return CentroTrabalhoAggregate(
      id: '',
      codigo: CodigoVO(null),
      nome: TextVO(''),
      turnos: [],
    );
  }

  @override
  bool operator ==(covariant CentroTrabalhoAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && listEquals(other.turnos, turnos);
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ turnos.hashCode;
  }

  bool get isValid => codigo.isValid && nome.isValid;
}
