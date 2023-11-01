// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/grupo_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/produto_entity.dart';

class OperacaoAggregate {
  final int ordem;
  final String nome;
  final CentroDeTrabalhoEntity centroDeTrabalho;
  final List<MaterialEntity> materiais;
  final List<GrupoDeRecursoEntity> grupoDeRecursos;

  const OperacaoAggregate({
    required this.ordem,
    required this.nome,
    required this.centroDeTrabalho,
    required this.materiais,
    required this.grupoDeRecursos,
  });

  OperacaoAggregate copyWith({
    int? ordem,
    String? nome,
    ProdutoEntity? produto,
    CentroDeTrabalhoEntity? centroDeTrabalho,
    List<MaterialEntity>? materiais,
    List<GrupoDeRecursoEntity>? grupoDeRecursos,
  }) {
    return OperacaoAggregate(
      ordem: ordem ?? this.ordem,
      nome: nome ?? this.nome,
      centroDeTrabalho: centroDeTrabalho ?? this.centroDeTrabalho,
      materiais: materiais ?? List.from(this.materiais),
      grupoDeRecursos: grupoDeRecursos ?? List.from(this.grupoDeRecursos),
    );
  }

  @override
  bool operator ==(covariant OperacaoAggregate other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.ordem == ordem &&
        other.nome == nome &&
        other.centroDeTrabalho == centroDeTrabalho &&
        listEquals(other.materiais, materiais) &&
        listEquals(other.grupoDeRecursos, grupoDeRecursos);
  }

  @override
  int get hashCode {
    return ordem.hashCode ^ nome.hashCode ^ centroDeTrabalho.hashCode ^ materiais.hashCode ^ grupoDeRecursos.hashCode;
  }
}
