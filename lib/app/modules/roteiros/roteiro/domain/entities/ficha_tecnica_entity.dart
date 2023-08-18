class FichaTecnicaEntity {
  final String id;
  final String codigo;
  final String descricao;

  const FichaTecnicaEntity({
    required this.id,
    required this.codigo,
    required this.descricao,
  });

  factory FichaTecnicaEntity.empty() {
    return const FichaTecnicaEntity(
      id: '',
      codigo: '',
      descricao: '',
    );
  }

  @override
  bool operator ==(covariant FichaTecnicaEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.descricao == descricao;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ descricao.hashCode;
}
