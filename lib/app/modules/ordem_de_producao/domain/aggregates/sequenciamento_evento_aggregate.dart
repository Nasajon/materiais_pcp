// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/operacao_roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/ordem_producao_entity.dart';

class SequenciamentoEventoAggregate {
  final String eventoRecursoId;
  final String? eventoRestricaoId;
  final String? recursoId;
  final String? restricaoId;
  final DoubleVO capacidade;
  final OrdemDeProducaoEntity ordemDeProducao;
  final OperacaoRoteiroEntity operacaoRoteiro;
  final DateVO inicioPlanejado;
  final DateVO fimPlanejado;

  const SequenciamentoEventoAggregate({
    required this.eventoRecursoId,
    this.eventoRestricaoId,
    this.recursoId,
    this.restricaoId,
    required this.capacidade,
    required this.ordemDeProducao,
    required this.operacaoRoteiro,
    required this.inicioPlanejado,
    required this.fimPlanejado,
  });

  SequenciamentoEventoAggregate copyWith({
    String? eventoRecursoId,
    String? eventoRestricaoId,
    String? recursoId,
    String? restricaoId,
    DoubleVO? capacidade,
    OrdemDeProducaoEntity? ordemDeProducao,
    OperacaoRoteiroEntity? operacaoRoteiro,
    DateVO? inicioPlanejado,
    DateVO? fimPlanejado,
  }) {
    return SequenciamentoEventoAggregate(
      eventoRecursoId: eventoRecursoId ?? this.eventoRecursoId,
      eventoRestricaoId: eventoRestricaoId ?? this.eventoRestricaoId,
      recursoId: recursoId ?? this.recursoId,
      restricaoId: restricaoId ?? this.restricaoId,
      capacidade: capacidade ?? this.capacidade,
      ordemDeProducao: ordemDeProducao ?? this.ordemDeProducao,
      operacaoRoteiro: operacaoRoteiro ?? this.operacaoRoteiro,
      inicioPlanejado: inicioPlanejado ?? this.inicioPlanejado,
      fimPlanejado: fimPlanejado ?? this.fimPlanejado,
    );
  }

  @override
  bool operator ==(covariant SequenciamentoEventoAggregate other) {
    if (identical(this, other)) return true;

    return other.eventoRecursoId == eventoRecursoId &&
        other.eventoRestricaoId == eventoRestricaoId &&
        other.recursoId == recursoId &&
        other.restricaoId == restricaoId &&
        other.capacidade == capacidade &&
        other.ordemDeProducao == ordemDeProducao &&
        other.operacaoRoteiro == operacaoRoteiro &&
        other.inicioPlanejado == inicioPlanejado &&
        other.fimPlanejado == fimPlanejado;
  }

  @override
  int get hashCode {
    return eventoRecursoId.hashCode ^
        eventoRestricaoId.hashCode ^
        recursoId.hashCode ^
        restricaoId.hashCode ^
        capacidade.hashCode ^
        ordemDeProducao.hashCode ^
        operacaoRoteiro.hashCode ^
        inicioPlanejado.hashCode ^
        fimPlanejado.hashCode;
  }
}
