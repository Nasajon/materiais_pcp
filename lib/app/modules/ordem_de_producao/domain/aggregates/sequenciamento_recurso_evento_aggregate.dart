// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/operacao_roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/ordem_producao_entity.dart';

class SequenciamentoRecursoEventoAggregate {
  final String id;
  final OrdemDeProducaoEntity ordemDeProducao;
  final OperacaoRoteiroEntity operacaoRoteiro;
  final DateVO inicioPlanejado;
  final DateVO fimPlanejado;

  const SequenciamentoRecursoEventoAggregate({
    required this.id,
    required this.ordemDeProducao,
    required this.operacaoRoteiro,
    required this.inicioPlanejado,
    required this.fimPlanejado,
  });

  SequenciamentoRecursoEventoAggregate copyWith({
    String? id,
    OrdemDeProducaoEntity? ordemDeProducao,
    OperacaoRoteiroEntity? operacaoRoteiro,
    DateVO? inicioPlanejado,
    DateVO? fimPlanejado,
  }) {
    return SequenciamentoRecursoEventoAggregate(
      id: id ?? this.id,
      ordemDeProducao: ordemDeProducao ?? this.ordemDeProducao,
      operacaoRoteiro: operacaoRoteiro ?? this.operacaoRoteiro,
      inicioPlanejado: inicioPlanejado ?? this.inicioPlanejado,
      fimPlanejado: fimPlanejado ?? this.fimPlanejado,
    );
  }

  @override
  bool operator ==(covariant SequenciamentoRecursoEventoAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.ordemDeProducao == ordemDeProducao &&
        other.operacaoRoteiro == operacaoRoteiro &&
        other.inicioPlanejado == inicioPlanejado &&
        other.fimPlanejado == fimPlanejado;
  }

  @override
  int get hashCode {
    return id.hashCode ^ ordemDeProducao.hashCode ^ operacaoRoteiro.hashCode ^ inicioPlanejado.hashCode ^ fimPlanejado.hashCode;
  }
}
