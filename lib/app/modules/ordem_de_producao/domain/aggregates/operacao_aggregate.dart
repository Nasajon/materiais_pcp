// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/grupo_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/material_entity.dart';

class OperacaoAggregate {
  final String id;
  final String roteiroId;
  final int ordem;
  final String nome;
  final CentroDeTrabalhoEntity centroDeTrabalho;
  final List<MaterialEntity> materiais;
  final List<GrupoDeRecursoEntity> grupoDeRecursos;

  const OperacaoAggregate({
    required this.id,
    required this.roteiroId,
    required this.ordem,
    required this.nome,
    required this.centroDeTrabalho,
    required this.materiais,
    required this.grupoDeRecursos,
  });

  OperacaoAggregate copyWith({
    String? id,
    String? roteiroId,
    int? ordem,
    String? nome,
    CentroDeTrabalhoEntity? centroDeTrabalho,
    List<MaterialEntity>? materiais,
    List<GrupoDeRecursoEntity>? grupoDeRecursos,
  }) {
    return OperacaoAggregate(
      id: id ?? this.id,
      roteiroId: roteiroId ?? this.roteiroId,
      ordem: ordem ?? this.ordem,
      nome: nome ?? this.nome,
      centroDeTrabalho: centroDeTrabalho ?? this.centroDeTrabalho,
      materiais: materiais ?? this.materiais,
      grupoDeRecursos: grupoDeRecursos ?? this.grupoDeRecursos,
    );
  }

  @override
  bool operator ==(covariant OperacaoAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.roteiroId == roteiroId &&
        other.ordem == ordem &&
        other.nome == nome &&
        other.centroDeTrabalho == centroDeTrabalho &&
        listEquals(other.materiais, materiais) &&
        listEquals(other.grupoDeRecursos, grupoDeRecursos);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roteiroId.hashCode ^
        ordem.hashCode ^
        nome.hashCode ^
        centroDeTrabalho.hashCode ^
        materiais.hashCode ^
        grupoDeRecursos.hashCode;
  }
}
