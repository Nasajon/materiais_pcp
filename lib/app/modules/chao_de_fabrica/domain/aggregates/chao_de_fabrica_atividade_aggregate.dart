// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_material_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_operacao_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_ordem_de_producao_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_unidade_entity.dart';

class ChaoDeFabricaAtividadeAggregate {
  final String id;
  final String codigo;
  final AtividadeStatusEnum status;
  final DateVO inicioPlanejado;
  final DateVO fimPlanejado;
  final DateVO inicioPreparacaoPlanejado;
  final DateVO fimPreparacaoPlanejado;
  final DateVO ultimaAtualizacao;
  final double progresso;
  final DoubleVO capacidade;
  final DoubleVO quantidade;
  final DoubleVO produzida;
  final ChaoDeFabricaUnidadeEntity unidade;
  final ChaoDeFabricaOrdemDeProducaoEntity ordemDeProducao;
  final ChaoDeFabricaOperacaoEntity operacao;
  final ChaoDeFabricaCentroDeTrabalhoEntity centroDeTrabalho;
  final ChaoDeFabricaRecursoEntity recurso;
  final List<ChaoDeFabricaRestricaoEntity> restricoes;
  final List<ChaoDeFabricaMaterialEntity> materiais;

  const ChaoDeFabricaAtividadeAggregate({
    required this.id,
    required this.codigo,
    required this.status,
    required this.inicioPlanejado,
    required this.fimPlanejado,
    required this.inicioPreparacaoPlanejado,
    required this.fimPreparacaoPlanejado,
    required this.ultimaAtualizacao,
    required this.progresso,
    required this.capacidade,
    required this.quantidade,
    required this.produzida,
    required this.unidade,
    required this.ordemDeProducao,
    required this.operacao,
    required this.centroDeTrabalho,
    required this.recurso,
    required this.restricoes,
    required this.materiais,
  });

  factory ChaoDeFabricaAtividadeAggregate.empty() {
    return ChaoDeFabricaAtividadeAggregate(
      id: '',
      codigo: '',
      status: AtividadeStatusEnum.aberta,
      inicioPlanejado: DateVO(''),
      fimPlanejado: DateVO(''),
      inicioPreparacaoPlanejado: DateVO(''),
      fimPreparacaoPlanejado: DateVO(''),
      ultimaAtualizacao: DateVO(''),
      progresso: 0,
      capacidade: DoubleVO(null),
      quantidade: DoubleVO(null),
      produzida: DoubleVO(null),
      unidade: ChaoDeFabricaUnidadeEntity.empty(),
      ordemDeProducao: ChaoDeFabricaOrdemDeProducaoEntity.empty(),
      operacao: ChaoDeFabricaOperacaoEntity.empty(),
      centroDeTrabalho: ChaoDeFabricaCentroDeTrabalhoEntity.empty(),
      recurso: ChaoDeFabricaRecursoEntity.empty(),
      restricoes: [],
      materiais: [],
    );
  }

  ChaoDeFabricaAtividadeAggregate copyWith({
    String? id,
    String? codigo,
    AtividadeStatusEnum? status,
    DateVO? inicioPlanejado,
    DateVO? fimPlanejado,
    DateVO? inicioPreparacaoPlanejado,
    DateVO? fimPreparacaoPlanejado,
    DateVO? ultimaAtualizacao,
    double? progresso,
    DoubleVO? capacidade,
    DoubleVO? quantidade,
    DoubleVO? produzida,
    ChaoDeFabricaUnidadeEntity? unidade,
    ChaoDeFabricaOrdemDeProducaoEntity? ordemDeProducao,
    ChaoDeFabricaOperacaoEntity? operacao,
    ChaoDeFabricaCentroDeTrabalhoEntity? centroDeTrabalho,
    ChaoDeFabricaRecursoEntity? recurso,
    List<ChaoDeFabricaRestricaoEntity>? restricoes,
    List<ChaoDeFabricaMaterialEntity>? materiais,
  }) {
    return ChaoDeFabricaAtividadeAggregate(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      status: status ?? this.status,
      inicioPlanejado: inicioPlanejado ?? this.inicioPlanejado,
      fimPlanejado: fimPlanejado ?? this.fimPlanejado,
      inicioPreparacaoPlanejado: inicioPreparacaoPlanejado ?? this.inicioPreparacaoPlanejado,
      fimPreparacaoPlanejado: fimPreparacaoPlanejado ?? this.fimPreparacaoPlanejado,
      ultimaAtualizacao: ultimaAtualizacao ?? this.ultimaAtualizacao,
      progresso: progresso ?? this.progresso,
      capacidade: capacidade ?? this.capacidade,
      quantidade: quantidade ?? this.quantidade,
      produzida: produzida ?? this.produzida,
      unidade: unidade ?? this.unidade,
      ordemDeProducao: ordemDeProducao ?? this.ordemDeProducao,
      operacao: operacao ?? this.operacao,
      centroDeTrabalho: centroDeTrabalho ?? this.centroDeTrabalho,
      recurso: recurso ?? this.recurso,
      restricoes: restricoes ?? this.restricoes,
      materiais: materiais ?? this.materiais,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaAtividadeAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.codigo == codigo &&
        other.status == status &&
        other.inicioPlanejado == inicioPlanejado &&
        other.fimPlanejado == fimPlanejado &&
        other.inicioPreparacaoPlanejado == inicioPreparacaoPlanejado &&
        other.fimPreparacaoPlanejado == fimPreparacaoPlanejado &&
        other.ultimaAtualizacao == ultimaAtualizacao &&
        other.progresso == progresso &&
        other.capacidade == capacidade &&
        other.quantidade == quantidade &&
        other.produzida == produzida &&
        other.unidade == unidade &&
        other.ordemDeProducao == ordemDeProducao &&
        other.operacao == operacao &&
        other.centroDeTrabalho == centroDeTrabalho &&
        other.recurso == recurso &&
        listEquals(other.restricoes, restricoes) &&
        listEquals(other.materiais, materiais);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        codigo.hashCode ^
        status.hashCode ^
        inicioPlanejado.hashCode ^
        fimPlanejado.hashCode ^
        inicioPreparacaoPlanejado.hashCode ^
        fimPreparacaoPlanejado.hashCode ^
        ultimaAtualizacao.hashCode ^
        progresso.hashCode ^
        capacidade.hashCode ^
        quantidade.hashCode ^
        produzida.hashCode ^
        unidade.hashCode ^
        ordemDeProducao.hashCode ^
        operacao.hashCode ^
        centroDeTrabalho.hashCode ^
        recurso.hashCode ^
        restricoes.hashCode ^
        materiais.hashCode;
  }
}
