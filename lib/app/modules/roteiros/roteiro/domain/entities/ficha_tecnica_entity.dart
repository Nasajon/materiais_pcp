class FichaTecnicaEntity {
  final String id;
  final String codigo;
  final String nome;

  const FichaTecnicaEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  @override
  bool operator ==(covariant FichaTecnicaEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
