class UnidadeEntity {
  final String id;
  final String? codigo;
  final String? nome;

  const UnidadeEntity({
    required this.id,
    this.codigo,
    this.nome,
  });

  factory UnidadeEntity.empty() {
    return const UnidadeEntity(id: '', codigo: '', nome: '');
  }

  @override
  bool operator ==(covariant UnidadeEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;

  bool get isValid => codigo != null && codigo!.isNotEmpty && nome != null && nome!.isNotEmpty;
}
