// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_produto_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';

class FichaTecnicaAggregate {
  final String id;
  final ProdutoEntity produto;
  final DoubleVO quantidade;
  final TextVO descricao;
  final TextVO codigo;
  final UnidadeEntity unidade;

  final List<FichaTecnicaMaterialAggregate> materiais;

  const FichaTecnicaAggregate({
    required this.id,
    required this.codigo,
    required this.quantidade,
    required this.materiais,
    required this.descricao,
    required this.produto,
    required this.unidade,
  });

  FichaTecnicaAggregate copyWith({
    String? id,
    ProdutoEntity? produto,
    TextVO? descricao,
    TextVO? codigo,
    DoubleVO? quantidade,
    UnidadeEntity? unidade,
    List<FichaTecnicaMaterialAggregate>? materiais,
  }) {
    return FichaTecnicaAggregate(
      id: id ?? this.id,
      produto: produto ?? this.produto,
      codigo: codigo ?? this.codigo,
      quantidade: quantidade ?? this.quantidade,
      unidade: unidade ?? this.unidade,
      descricao: descricao ?? this.descricao,
      materiais: materiais ?? List.from(this.materiais),
    );
  }

  factory FichaTecnicaAggregate.empty() {
    return FichaTecnicaAggregate(
      id: '',
      quantidade: DoubleVO(null),
      codigo: TextVO(''),
      descricao: TextVO(''),
      produto: ProdutoEntity.empty(),
      unidade: UnidadeEntity.empty(),
      materiais: [],
    );
  }

  @override
  bool operator ==(covariant FichaTecnicaAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.produto == produto &&
        other.unidade == unidade &&
        listEquals(other.materiais, materiais) &&
        other.codigo == codigo &&
        other.descricao == descricao &&
        other.quantidade == quantidade;
  }

  @override
  int get hashCode {
    return id.hashCode ^ produto.hashCode ^ unidade.hashCode ^ materiais.hashCode ^ codigo.hashCode;
  }

  bool get isMateriaisValid => materiais.isNotEmpty;

  bool get isValid => quantidade.isValid && produto != ProdutoEntity.empty() && unidade != UnidadeEntity.empty() && codigo.isValid;
}
