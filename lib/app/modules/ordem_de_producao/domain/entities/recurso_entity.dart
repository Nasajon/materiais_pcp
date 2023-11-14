class RecursoEntity {
  final String id;
  final String codigo;
  final String nome;

  const RecursoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  RecursoEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
  }) {
    return RecursoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant RecursoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
