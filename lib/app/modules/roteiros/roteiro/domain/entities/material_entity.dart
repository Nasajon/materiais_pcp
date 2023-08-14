// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';

class MaterialEntity {
  final String id;
  final ProdutoEntity produto;
  final UnidadeEntity unidade;
  final double disponivel;
  final double quantidade;

  const MaterialEntity({
    required this.id,
    required this.produto,
    required this.unidade,
    required this.disponivel,
    required this.quantidade,
  });

  MaterialEntity copyWith({
    String? id,
    ProdutoEntity? produto,
    UnidadeEntity? unidade,
    double? disponivel,
    double? quantidade,
  }) {
    return MaterialEntity(
      id: id ?? this.id,
      produto: produto ?? this.produto,
      unidade: unidade ?? this.unidade,
      disponivel: disponivel ?? this.disponivel,
      quantidade: quantidade ?? this.quantidade,
    );
  }

  @override
  bool operator ==(covariant MaterialEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.produto == produto &&
        other.unidade == unidade &&
        other.disponivel == disponivel &&
        other.quantidade == quantidade;
  }

  @override
  int get hashCode {
    return id.hashCode ^ produto.hashCode ^ unidade.hashCode ^ disponivel.hashCode ^ quantidade.hashCode;
  }
}
