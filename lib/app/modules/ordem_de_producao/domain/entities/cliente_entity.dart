class ClienteEntity {
  final String id;
  final String codigo;
  final String nome;

  const ClienteEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  factory ClienteEntity.empty() {
    return const ClienteEntity(id: '', codigo: '', nome: '');
  }

  ClienteEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
  }) {
    return ClienteEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant ClienteEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
