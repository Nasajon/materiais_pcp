// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_material_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_operacao_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_ordem_de_producao_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_unidade_entity.dart';

class ChaoDeFabricaAtividadeAggregate {
  final String id;
  final AtividadeStatusEnum status;
  final DateVO inicioPlanejado;
  final DateVO fimPlanejado;
  final DateVO inicioPreparacaoPlanejado;
  final DateVO fimPreparacaoPlanejado;
  final double progresso;
  final DoubleVO capacidade;
  final ChaoDeFabricaUnidadeEntity unidade;
  final ChaoDeFabricaOrdemDeProducaoEntity ordemDeProducao;
  final ChaoDeFabricaOperacaoEntity operacao;
  final ChaoDeFabricaRecursoEntity recurso;
  final List<ChaoDeFabricaRestricaoEntity> restricoes;
  final List<ChaoDeFabricaMaterialEntity> materiais;

  const ChaoDeFabricaAtividadeAggregate({
    required this.id,
    required this.status,
    required this.inicioPlanejado,
    required this.fimPlanejado,
    required this.inicioPreparacaoPlanejado,
    required this.fimPreparacaoPlanejado,
    required this.progresso,
    required this.capacidade,
    required this.unidade,
    required this.ordemDeProducao,
    required this.operacao,
    required this.recurso,
    required this.restricoes,
    required this.materiais,
  });

  ChaoDeFabricaAtividadeAggregate copyWith({
    String? id,
    AtividadeStatusEnum? status,
    DateVO? inicioPlanejado,
    DateVO? fimPlanejado,
    DateVO? inicioPreparacaoPlanejado,
    DateVO? fimPreparacaoPlanejado,
    double? progresso,
    DoubleVO? capacidade,
    ChaoDeFabricaUnidadeEntity? unidade,
    ChaoDeFabricaOrdemDeProducaoEntity? ordemDeProducao,
    ChaoDeFabricaOperacaoEntity? operacao,
    ChaoDeFabricaRecursoEntity? recurso,
    List<ChaoDeFabricaRestricaoEntity>? restricoes,
    List<ChaoDeFabricaMaterialEntity>? materiais,
  }) {
    return ChaoDeFabricaAtividadeAggregate(
      id: id ?? this.id,
      status: status ?? this.status,
      inicioPlanejado: inicioPlanejado ?? this.inicioPlanejado,
      fimPlanejado: fimPlanejado ?? this.fimPlanejado,
      inicioPreparacaoPlanejado: inicioPreparacaoPlanejado ?? this.inicioPreparacaoPlanejado,
      fimPreparacaoPlanejado: fimPreparacaoPlanejado ?? this.fimPreparacaoPlanejado,
      progresso: progresso ?? this.progresso,
      capacidade: capacidade ?? this.capacidade,
      unidade: unidade ?? this.unidade,
      ordemDeProducao: ordemDeProducao ?? this.ordemDeProducao,
      operacao: operacao ?? this.operacao,
      recurso: recurso ?? this.recurso,
      restricoes: restricoes ?? this.restricoes,
      materiais: materiais ?? this.materiais,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaAtividadeAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.status == status &&
        other.inicioPlanejado == inicioPlanejado &&
        other.fimPlanejado == fimPlanejado &&
        other.inicioPreparacaoPlanejado == inicioPreparacaoPlanejado &&
        other.fimPreparacaoPlanejado == fimPreparacaoPlanejado &&
        other.progresso == progresso &&
        other.capacidade == capacidade &&
        other.unidade == unidade &&
        other.ordemDeProducao == ordemDeProducao &&
        other.operacao == operacao &&
        other.recurso == recurso &&
        listEquals(other.restricoes, restricoes) &&
        listEquals(other.materiais, materiais);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        inicioPlanejado.hashCode ^
        fimPlanejado.hashCode ^
        inicioPreparacaoPlanejado.hashCode ^
        fimPreparacaoPlanejado.hashCode ^
        progresso.hashCode ^
        capacidade.hashCode ^
        unidade.hashCode ^
        ordemDeProducao.hashCode ^
        operacao.hashCode ^
        recurso.hashCode ^
        restricoes.hashCode ^
        materiais.hashCode;
  }
}
