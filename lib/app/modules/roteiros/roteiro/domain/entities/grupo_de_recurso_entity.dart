class GrupoDeRecursoEntity {
  final String id;
  final String codigo;
  final String nome;

  const GrupoDeRecursoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  factory GrupoDeRecursoEntity.empty() {
    return const GrupoDeRecursoEntity(
      id: '',
      codigo: '',
      nome: '',
    );
  }

  @override
  bool operator ==(covariant GrupoDeRecursoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
