import 'package:collection/collection.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';

class RoteiroAggregate {
  final String id;
  final CodigoVO codigo;
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
    required this.codigo,
    required this.descricao,
    required this.inicio,
    required this.fim,
    this.observacao,
    required this.produto,
    required this.fichaTecnica,
    required this.unidade,
    required this.operacoes,
  });

  factory RoteiroAggregate.empty() {
    return RoteiroAggregate(
      id: '',
      codigo: CodigoVO(null),
      descricao: TextVO(''),
      inicio: DateVO(''),
      fim: DateVO(''),
      produto: ProdutoEntity.empty(),
      fichaTecnica: FichaTecnicaEntity.empty(),
      unidade: UnidadeEntity.empty(),
      operacoes: [],
    );
  }

  RoteiroAggregate copyWith({
    String? id,
    CodigoVO? codigo,
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
      codigo: codigo ?? this.codigo,
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
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.codigo == codigo &&
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
        codigo.hashCode ^
        descricao.hashCode ^
        inicio.hashCode ^
        fim.hashCode ^
        observacao.hashCode ^
        produto.hashCode ^
        fichaTecnica.hashCode ^
        unidade.hashCode ^
        operacoes.hashCode;
  }

  bool get dadosBasicosIsValid =>
      codigo.isValid && //
      produto.id.isNotEmpty &&
      descricao.isValid &&
      fichaTecnica.id.isNotEmpty &&
      unidade.id.isNotEmpty;

  bool get periodoDeVigenciaIsValid => inicio.isValid && fim.isValid;

  bool get operacoesIsValid => operacoes.isNotEmpty;

  bool get isValid =>
      dadosBasicosIsValid && //
      periodoDeVigenciaIsValid &&
      operacoesIsValid;
}
