class ProdutoEntity {
  final String id;
  final String codigo;
  final String nome;

  const ProdutoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  factory ProdutoEntity.empty() {
    return const ProdutoEntity(id: '', codigo: '', nome: '');
  }

  ProdutoEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
  }) {
    return ProdutoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant ProdutoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
