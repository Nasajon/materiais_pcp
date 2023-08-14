import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/enums/medicao_tempo_enum.dart';

class OperacaoAggregate {
  final CodigoVO codigo;
  final TextVO nome;
  final DoubleVO razaoConversao;
  final TimeVO preparacao;
  final TimeVO execucao;
  final String produtoResultante;
  final MedicaoTempoEnum medicaoTempo;
  final UnidadeEntity unidade;
  final CentroDeTrabalhoEntity centroDeTrabalho;
  final List<MaterialEntity> material;
  final List<GrupoDeRecursoAggregate> gruposDeRecurso;

  const OperacaoAggregate({
    required this.codigo,
    required this.nome,
    required this.razaoConversao,
    required this.preparacao,
    required this.execucao,
    required this.produtoResultante,
    required this.medicaoTempo,
    required this.unidade,
    required this.centroDeTrabalho,
    required this.material,
    required this.gruposDeRecurso,
  });

  OperacaoAggregate copyWith({
    CodigoVO? codigo,
    TextVO? nome,
    DoubleVO? razaoConversao,
    TimeVO? preparacao,
    TimeVO? execucao,
    String? produtoResultante,
    MedicaoTempoEnum? medicaoTempo,
    UnidadeEntity? unidade,
    CentroDeTrabalhoEntity? centroDeTrabalho,
    List<MaterialEntity>? material,
    List<GrupoDeRecursoAggregate>? gruposDeRecurso,
  }) {
    return OperacaoAggregate(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      razaoConversao: razaoConversao ?? this.razaoConversao,
      preparacao: preparacao ?? this.preparacao,
      execucao: execucao ?? this.execucao,
      produtoResultante: produtoResultante ?? this.produtoResultante,
      medicaoTempo: medicaoTempo ?? this.medicaoTempo,
      unidade: unidade ?? this.unidade,
      centroDeTrabalho: centroDeTrabalho ?? this.centroDeTrabalho,
      material: material ?? List.from(this.material),
      gruposDeRecurso: gruposDeRecurso ?? List.from(this.gruposDeRecurso),
    );
  }

  @override
  bool operator ==(covariant OperacaoAggregate other) {
    if (identical(this, other)) return true;

    return other.codigo == codigo &&
        other.nome == nome &&
        other.razaoConversao == razaoConversao &&
        other.preparacao == preparacao &&
        other.execucao == execucao &&
        other.produtoResultante == produtoResultante &&
        other.medicaoTempo == medicaoTempo &&
        other.unidade == unidade &&
        other.centroDeTrabalho == centroDeTrabalho &&
        listEquals(other.material, material) &&
        listEquals(other.gruposDeRecurso, gruposDeRecurso);
  }

  @override
  int get hashCode {
    return codigo.hashCode ^
        nome.hashCode ^
        razaoConversao.hashCode ^
        preparacao.hashCode ^
        execucao.hashCode ^
        produtoResultante.hashCode ^
        medicaoTempo.hashCode ^
        unidade.hashCode ^
        centroDeTrabalho.hashCode ^
        material.hashCode ^
        gruposDeRecurso.hashCode;
  }
}
