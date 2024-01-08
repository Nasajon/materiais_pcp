// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/turno_de_trabalho_entity.dart';

class Recurso {
  final String? id;
  final CodigoVO codigo;
  final TextVO descricao;
  final GrupoDeRecurso? grupoDeRecurso;
  final RecursoCentroDeTrabalho? centroDeTrabalho;
  final List<TurnoDeTrabalhoEntity> turnos;

  const Recurso({
    this.id,
    required this.codigo,
    required this.descricao,
    this.grupoDeRecurso,
    this.centroDeTrabalho,
    required this.turnos,
  });

  factory Recurso.empty() {
    return Recurso(
      codigo: CodigoVO(null),
      descricao: TextVO(''),
      turnos: [],
    );
  }

  Recurso copyWith({
    String? id,
    CodigoVO? codigo,
    TextVO? descricao,
    GrupoDeRecurso? grupoDeRecurso,
    RecursoCentroDeTrabalho? centroDeTrabalho,
    List<TurnoDeTrabalhoEntity>? turnos,
  }) {
    return Recurso(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      grupoDeRecurso: grupoDeRecurso ?? this.grupoDeRecurso,
      centroDeTrabalho: centroDeTrabalho ?? this.centroDeTrabalho,
      turnos: turnos ?? this.turnos,
    );
  }

  @override
  bool operator ==(covariant Recurso other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.codigo == codigo &&
        other.descricao == descricao &&
        other.grupoDeRecurso == grupoDeRecurso &&
        other.centroDeTrabalho == centroDeTrabalho &&
        listEquals(other.turnos, turnos);
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ descricao.hashCode ^ grupoDeRecurso.hashCode ^ centroDeTrabalho.hashCode ^ turnos.hashCode;
  }
}
