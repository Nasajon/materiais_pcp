import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';

class ProdutoEntity {
  final String id;
  final String? codigo;
  final String? nome;

  const ProdutoEntity({
    required this.id,
    this.codigo,
    this.nome,
  });

  factory ProdutoEntity.empty() {
    return const ProdutoEntity(id: '', codigo: '', nome: '');
  }

  @override
  bool operator ==(covariant ProdutoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;

  bool get isValid => codigo != null && codigo!.isNotEmpty && nome != null && nome!.isNotEmpty;
}
