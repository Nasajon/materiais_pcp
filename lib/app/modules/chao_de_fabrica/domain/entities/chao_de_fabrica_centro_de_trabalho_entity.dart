class ChaoDeFabricaCentroDeTrabalhoEntity {
  final String id;
  final String codigo;
  final String nome;

  const ChaoDeFabricaCentroDeTrabalhoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  factory ChaoDeFabricaCentroDeTrabalhoEntity.empty() {
    return const ChaoDeFabricaCentroDeTrabalhoEntity(id: '', codigo: '', nome: '');
  }

  ChaoDeFabricaCentroDeTrabalhoEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
  }) {
    return ChaoDeFabricaCentroDeTrabalhoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaCentroDeTrabalhoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
