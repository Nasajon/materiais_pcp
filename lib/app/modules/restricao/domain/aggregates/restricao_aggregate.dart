// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/indisponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/turno_de_trabalho_entity.dart';

class RestricaoAggregate {
  final String? id;
  final CodigoVO codigo;
  final TextVO descricao;
  final RestricaoGrupoDeRestricaoEntity grupoDeRestricao;
  final List<IndisponibilidadeEntity> indisponibilidades;
  final RestricaoCentroDeTrabalho centroDeTrabalho;
  final List<TurnoDeTrabalhoEntity> turnos;

  const RestricaoAggregate({
    this.id,
    required this.codigo,
    required this.descricao,
    required this.grupoDeRestricao,
    required this.indisponibilidades,
    required this.centroDeTrabalho,
    required this.turnos,
  });

  factory RestricaoAggregate.empty() {
    return RestricaoAggregate(
      codigo: CodigoVO(null),
      descricao: TextVO(''),
      grupoDeRestricao: RestricaoGrupoDeRestricaoEntity.empty(),
      centroDeTrabalho: RestricaoCentroDeTrabalho.empty(),
      indisponibilidades: [],
      turnos: [],
    );
  }

  RestricaoAggregate copyWith({
    String? id,
    CodigoVO? codigo,
    TextVO? descricao,
    RestricaoGrupoDeRestricaoEntity? grupoDeRestricao,
    List<IndisponibilidadeEntity>? indisponibilidades,
    RestricaoCentroDeTrabalho? centroDeTrabalho,
    List<TurnoDeTrabalhoEntity>? turnos,
  }) {
    return RestricaoAggregate(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      grupoDeRestricao: grupoDeRestricao ?? this.grupoDeRestricao,
      indisponibilidades: indisponibilidades ?? this.indisponibilidades,
      centroDeTrabalho: centroDeTrabalho ?? this.centroDeTrabalho,
      turnos: turnos ?? this.turnos,
    );
  }

  @override
  bool operator ==(covariant RestricaoAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.codigo == codigo &&
        other.descricao == descricao &&
        other.grupoDeRestricao == grupoDeRestricao &&
        listEquals(other.indisponibilidades, indisponibilidades) &&
        other.centroDeTrabalho == centroDeTrabalho &&
        listEquals(other.turnos, turnos);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        codigo.hashCode ^
        descricao.hashCode ^
        grupoDeRestricao.hashCode ^
        indisponibilidades.hashCode ^
        centroDeTrabalho.hashCode ^
        turnos.hashCode;
  }

  bool get dadosGeraisIsValid => (codigo.isValid) && descricao.isValid && grupoDeRestricao != RestricaoGrupoDeRestricaoEntity.empty();

  bool get indisponibilidadeIsValid => true;

  bool get isValid => dadosGeraisIsValid && indisponibilidadeIsValid;
}
