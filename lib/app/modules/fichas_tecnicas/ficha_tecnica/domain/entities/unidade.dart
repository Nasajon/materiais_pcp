class UnidadeEntity {
  final String id;
  final String? codigo;
  final String? nome;
  final int? decimais;

  const UnidadeEntity({
    required this.id,
    this.codigo,
    this.nome,
    this.decimais,
  });

  factory UnidadeEntity.empty() {
    return const UnidadeEntity(id: '', codigo: '', nome: '', decimais: 0);
  }

  @override
  bool operator ==(covariant UnidadeEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && decimais == other.decimais;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ decimais.hashCode;

  bool get isValid => codigo != null && codigo!.isNotEmpty && nome != null && nome!.isNotEmpty;
}
