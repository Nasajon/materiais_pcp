class CentroDeTrabalhoEntity {
  final String id;
  final String codigo;
  final String nome;

  const CentroDeTrabalhoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  factory CentroDeTrabalhoEntity.empty() {
    return const CentroDeTrabalhoEntity(
      id: '',
      codigo: '',
      nome: '',
    );
  }

  @override
  bool operator ==(covariant CentroDeTrabalhoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
