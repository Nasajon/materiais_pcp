// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/unidade.dart';

class FichaTecnicaMaterialAggregate {
  final String? id;
  final int codigo;
  final ProdutoEntity produto;
  final DoubleVO quantidade;
  final UnidadeEntity unidade;

  const FichaTecnicaMaterialAggregate({
    this.id,
    required this.codigo,
    required this.produto,
    required this.quantidade,
    required this.unidade,
  });

  factory FichaTecnicaMaterialAggregate.empty() {
    return FichaTecnicaMaterialAggregate(
      id: null,
      codigo: 0,
      quantidade: DoubleVO(null),
      produto: ProdutoEntity.empty(),
      unidade: UnidadeEntity.empty(),
    );
  }

  FichaTecnicaMaterialAggregate copyWith({
    String? id,
    ProdutoEntity? produto,
    int? codigo,
    DoubleVO? quantidade,
    UnidadeEntity? unidade,
  }) {
    return FichaTecnicaMaterialAggregate(
      id: id ?? this.id,
      produto: produto ?? this.produto,
      codigo: codigo ?? this.codigo,
      quantidade: quantidade ?? this.quantidade,
      unidade: unidade ?? this.unidade,
    );
  }

  @override
  bool operator ==(covariant FichaTecnicaMaterialAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.produto == produto &&
        other.unidade == unidade &&
        other.codigo == codigo &&
        other.quantidade == quantidade;
  }

  @override
  int get hashCode {
    return id.hashCode ^ produto.hashCode ^ unidade.hashCode;
  }

  bool get isValid => quantidade.isValid && produto.id.isNotEmpty && unidade.id.isNotEmpty;
}
