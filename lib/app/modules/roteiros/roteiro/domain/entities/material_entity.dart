// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';

class MaterialEntity {
  final String id;
  final String fichaTecnicaId;
  final ProdutoEntity produto;
  final UnidadeEntity unidade;
  final DoubleVO disponivel;
  final DoubleVO quantidade;

  const MaterialEntity({
    this.id = '',
    required this.fichaTecnicaId,
    required this.produto,
    required this.unidade,
    required this.disponivel,
    required this.quantidade,
  });

  MaterialEntity copyWith({
    String? id,
    String? fichaTecnicaId,
    ProdutoEntity? produto,
    UnidadeEntity? unidade,
    DoubleVO? disponivel,
    DoubleVO? quantidade,
  }) {
    return MaterialEntity(
      id: id ?? this.id,
      fichaTecnicaId: fichaTecnicaId ?? this.fichaTecnicaId,
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
        other.fichaTecnicaId == fichaTecnicaId &&
        other.produto == produto &&
        other.unidade == unidade &&
        other.disponivel == disponivel &&
        other.quantidade == quantidade;
  }

  @override
  int get hashCode {
    return id.hashCode ^ fichaTecnicaId.hashCode ^ produto.hashCode ^ unidade.hashCode ^ disponivel.hashCode ^ quantidade.hashCode;
  }
}
