import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/unidade_entity.dart';

class MaterialEntity {
  final String id;
  final DoubleVO quantidade;
  final ProdutoEntity produto;
  final UnidadeEntity unidade;

  const MaterialEntity({
    required this.id,
    required this.quantidade,
    required this.produto,
    required this.unidade,
  });

  MaterialEntity copyWith({
    String? id,
    String? fichaTecnicaId,
    DoubleVO? quantidade,
    ProdutoEntity? produto,
    UnidadeEntity? unidade,
  }) {
    return MaterialEntity(
      id: id ?? this.id,
      quantidade: quantidade ?? this.quantidade,
      produto: produto ?? this.produto,
      unidade: unidade ?? this.unidade,
    );
  }

  @override
  bool operator ==(covariant MaterialEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.quantidade == quantidade && other.produto == produto && other.unidade == unidade;
  }

  @override
  int get hashCode {
    return id.hashCode ^ quantidade.hashCode ^ produto.hashCode ^ unidade.hashCode;
  }
}
