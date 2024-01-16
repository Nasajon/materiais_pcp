// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/grupo_de_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/roteiro_medicao_tempo_enum.dart';

class OperacaoAggregate {
  final String id;
  final int ordem;
  final TextVO nome;
  final DoubleVO razaoConversao;
  final TimeVO preparacao;
  final TimeVO execucao;
  final ProdutoEntity? produtoResultante;
  final RoteiroMedicaoTempoEnum? medicaoTempo;
  final UnidadeEntity unidade;
  final CentroDeTrabalhoEntity centroDeTrabalho;
  final List<MaterialEntity> materiais;
  final List<GrupoDeRecursoAggregate> gruposDeRecurso;

  const OperacaoAggregate({
    this.id = '',
    required this.ordem,
    required this.nome,
    required this.razaoConversao,
    required this.preparacao,
    required this.execucao,
    required this.produtoResultante,
    this.medicaoTempo,
    required this.unidade,
    required this.centroDeTrabalho,
    required this.materiais,
    required this.gruposDeRecurso,
  });

  factory OperacaoAggregate.empty() {
    return OperacaoAggregate(
      ordem: 0,
      nome: TextVO(''),
      razaoConversao: DoubleVO(null),
      preparacao: TimeVO(''),
      execucao: TimeVO(''),
      produtoResultante: null,
      unidade: UnidadeEntity.empty(),
      centroDeTrabalho: CentroDeTrabalhoEntity.empty(),
      materiais: [],
      gruposDeRecurso: [],
    );
  }

  OperacaoAggregate copyWith({
    String? id,
    int? ordem,
    TextVO? nome,
    DoubleVO? razaoConversao,
    TimeVO? preparacao,
    TimeVO? execucao,
    ProdutoEntity? produtoResultante,
    RoteiroMedicaoTempoEnum? medicaoTempo,
    UnidadeEntity? unidade,
    CentroDeTrabalhoEntity? centroDeTrabalho,
    List<MaterialEntity>? materiais,
    List<GrupoDeRecursoAggregate>? gruposDeRecurso,
  }) {
    return OperacaoAggregate(
      id: id ?? this.id,
      ordem: ordem ?? this.ordem,
      nome: nome ?? this.nome,
      razaoConversao: razaoConversao ?? this.razaoConversao,
      preparacao: preparacao ?? this.preparacao,
      execucao: execucao ?? this.execucao,
      produtoResultante: produtoResultante,
      medicaoTempo: medicaoTempo ?? this.medicaoTempo,
      unidade: unidade ?? this.unidade,
      centroDeTrabalho: centroDeTrabalho ?? this.centroDeTrabalho,
      materiais: materiais ?? List.from(this.materiais),
      gruposDeRecurso: gruposDeRecurso ?? List.from(this.gruposDeRecurso),
    );
  }

  @override
  bool operator ==(covariant OperacaoAggregate other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.ordem == ordem &&
        other.nome == nome &&
        other.razaoConversao == razaoConversao &&
        other.preparacao == preparacao &&
        other.execucao == execucao &&
        other.produtoResultante == produtoResultante &&
        other.medicaoTempo == medicaoTempo &&
        other.unidade == unidade &&
        other.centroDeTrabalho == centroDeTrabalho &&
        listEquals(other.materiais, materiais) &&
        listEquals(other.gruposDeRecurso, gruposDeRecurso);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ordem.hashCode ^
        nome.hashCode ^
        razaoConversao.hashCode ^
        preparacao.hashCode ^
        execucao.hashCode ^
        produtoResultante.hashCode ^
        medicaoTempo.hashCode ^
        unidade.hashCode ^
        centroDeTrabalho.hashCode ^
        materiais.hashCode ^
        gruposDeRecurso.hashCode;
  }

  int get codigo => ordem * 10;

  bool get isValid =>
      nome.isValid &&
      unidade.id.isNotEmpty &&
      razaoConversao.isValid &&
      (medicaoTempo != null && medicaoTempo!.value.isNotEmpty) &&
      preparacao.isValid &&
      execucao.isValid &&
      centroDeTrabalho.id.isNotEmpty &&
      gruposDeRecurso.isNotEmpty;
}
