import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_produto_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_unidade_entity.dart';

class ChaoDeFabricaMaterialEntity {
  final String id;
  final ChaoDeFabricaProdutoEntity produto;
  final ChaoDeFabricaUnidadeEntity unidade;
  final DoubleVO quantidade;

  const ChaoDeFabricaMaterialEntity({
    required this.id,
    required this.produto,
    required this.unidade,
    required this.quantidade,
  });

  ChaoDeFabricaMaterialEntity copyWith({
    String? id,
    ChaoDeFabricaProdutoEntity? produto,
    ChaoDeFabricaUnidadeEntity? unidade,
    DoubleVO? quantidade,
  }) {
    return ChaoDeFabricaMaterialEntity(
      id: id ?? this.id,
      produto: produto ?? this.produto,
      unidade: unidade ?? this.unidade,
      quantidade: quantidade ?? this.quantidade,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaMaterialEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.produto == produto && other.unidade == unidade && other.quantidade == quantidade;
  }

  @override
  int get hashCode {
    return id.hashCode ^ produto.hashCode ^ unidade.hashCode ^ quantidade.hashCode;
  }
}
