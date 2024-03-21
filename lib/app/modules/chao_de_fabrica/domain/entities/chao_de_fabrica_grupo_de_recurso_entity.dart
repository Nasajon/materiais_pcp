class ChaoDeFabricaGrupoDeRecursoEntity {
  final String id;
  final String codigo;
  final String nome;

  const ChaoDeFabricaGrupoDeRecursoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  factory ChaoDeFabricaGrupoDeRecursoEntity.empty() {
    return const ChaoDeFabricaGrupoDeRecursoEntity(
      id: '',
      codigo: '',
      nome: '',
    );
  }

  ChaoDeFabricaGrupoDeRecursoEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
  }) {
    return ChaoDeFabricaGrupoDeRecursoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaGrupoDeRecursoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
