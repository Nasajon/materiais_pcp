import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';

class RoteiroAggregate {
  final String id;
  final TextVO descricao;
  final DateVO inicio;
  final DateVO fim;
  final String? observacao;
  final ProdutoEntity produto;
  final FichaTecnicaEntity fichaTecnica;
  final UnidadeEntity unidade;
  final List<OperacaoAggregate> operacoes;

  const RoteiroAggregate({
    required this.id,
    required this.descricao,
    required this.inicio,
    required this.fim,
    this.observacao,
    required this.produto,
    required this.fichaTecnica,
    required this.unidade,
    required this.operacoes,
  });

  RoteiroAggregate copyWith({
    String? id,
    TextVO? descricao,
    DateVO? inicio,
    DateVO? fim,
    String? observacao,
    ProdutoEntity? produto,
    FichaTecnicaEntity? fichaTecnica,
    UnidadeEntity? unidade,
    List<OperacaoAggregate>? operacoes,
  }) {
    return RoteiroAggregate(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      inicio: inicio ?? this.inicio,
      fim: fim ?? this.fim,
      observacao: observacao ?? this.observacao,
      produto: produto ?? this.produto,
      fichaTecnica: fichaTecnica ?? this.fichaTecnica,
      unidade: unidade ?? this.unidade,
      operacoes: operacoes ?? List.from(this.operacoes),
    );
  }

  @override
  bool operator ==(covariant RoteiroAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.descricao == descricao &&
        other.inicio == inicio &&
        other.fim == fim &&
        other.observacao == observacao &&
        other.produto == produto &&
        other.fichaTecnica == fichaTecnica &&
        other.unidade == unidade &&
        listEquals(other.operacoes, operacoes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        descricao.hashCode ^
        inicio.hashCode ^
        fim.hashCode ^
        observacao.hashCode ^
        produto.hashCode ^
        fichaTecnica.hashCode ^
        unidade.hashCode ^
        operacoes.hashCode;
  }
}
