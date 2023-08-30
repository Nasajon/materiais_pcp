class GrupoDeRestricaoEntity {
  final String id;
  final String codigo;
  final String nome;

  const GrupoDeRestricaoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  factory GrupoDeRestricaoEntity.empty() {
    return const GrupoDeRestricaoEntity(
      id: '',
      codigo: '',
      nome: '',
    );
  }

  @override
  bool operator ==(covariant GrupoDeRestricaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
