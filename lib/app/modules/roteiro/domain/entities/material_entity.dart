// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/unidade_entity.dart';

class MaterialEntity {
  final String? id;
  final String? fichaTecnicaId;
  final ProdutoEntity produto;
  final UnidadeEntity unidade;
  final DoubleVO disponivel;
  final DoubleVO quantidade;
  final bool produtoAdicional;

  const MaterialEntity({
    this.id,
    required this.fichaTecnicaId,
    required this.produto,
    required this.unidade,
    required this.disponivel,
    required this.quantidade,
    this.produtoAdicional = false,
  });

  MaterialEntity copyWith({
    String? id,
    String? fichaTecnicaId,
    ProdutoEntity? produto,
    UnidadeEntity? unidade,
    DoubleVO? disponivel,
    DoubleVO? quantidade,
    bool? produtoAdicional,
  }) {
    return MaterialEntity(
      id: id ?? this.id,
      fichaTecnicaId: fichaTecnicaId ?? this.fichaTecnicaId,
      produto: produto ?? this.produto,
      unidade: unidade ?? this.unidade,
      disponivel: disponivel ?? this.disponivel,
      quantidade: quantidade ?? this.quantidade,
      produtoAdicional: produtoAdicional ?? this.produtoAdicional,
    );
  }

  @override
  bool operator ==(covariant MaterialEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fichaTecnicaId == fichaTecnicaId &&
        other.produto == produto &&
        other.unidade == unidade &&
        other.disponivel == disponivel &&
        other.quantidade == quantidade &&
        other.produtoAdicional == produtoAdicional;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fichaTecnicaId.hashCode ^
        produto.hashCode ^
        unidade.hashCode ^
        disponivel.hashCode ^
        quantidade.hashCode ^
        produtoAdicional.hashCode;
  }
}
