class ChaoDeFabricaRecursoEntity {
  final String id;
  final String codigo;
  final String nome;

  const ChaoDeFabricaRecursoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  factory ChaoDeFabricaRecursoEntity.empty() {
    return const ChaoDeFabricaRecursoEntity(id: '', codigo: '', nome: '');
  }

  ChaoDeFabricaRecursoEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
  }) {
    return ChaoDeFabricaRecursoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaRecursoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
