class ChaoDeFabricaProdutoEntity {
  final String id;
  final String codigo;
  final String nome;

  const ChaoDeFabricaProdutoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  ChaoDeFabricaProdutoEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
  }) {
    return ChaoDeFabricaProdutoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaProdutoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
