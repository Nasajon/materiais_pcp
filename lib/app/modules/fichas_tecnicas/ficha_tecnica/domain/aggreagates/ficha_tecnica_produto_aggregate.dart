// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';

class FichaTecnicaMaterialAggregate {
  final String id;
  final int codigo;
  final ProdutoEntity? produto;
  final MoedaVO? quantidade;
  final UnidadeEntity? unidade;

  const FichaTecnicaMaterialAggregate({
    required this.id,
    required this.codigo,
    this.produto,
    required this.quantidade,
    this.unidade,
  });

  FichaTecnicaMaterialAggregate copyWith({
    String? id,
    ProdutoEntity? produto,
    int? codigo,
    MoedaVO? quantidade,
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

  factory FichaTecnicaMaterialAggregate.empty() {
    return FichaTecnicaMaterialAggregate(
      id: '',
      quantidade: MoedaVO(null),
      codigo: 0,
      produto: ProdutoEntity.empty(),
      unidade: UnidadeEntity.empty(),
    );
  }

  @override
  bool operator ==(covariant FichaTecnicaMaterialAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id && other.produto == produto && other.unidade == unidade && other.codigo == codigo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ produto.hashCode ^ unidade.hashCode;
  }

  bool get isValid => quantidade != null && quantidade!.isValid && produto != null && unidade != null;
}
