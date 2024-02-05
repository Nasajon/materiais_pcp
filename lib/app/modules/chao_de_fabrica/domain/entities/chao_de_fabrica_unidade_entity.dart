class ChaoDeFabricaUnidadeEntity {
  final String id;
  final String codigo;
  final String nome;
  final int decimal;

  const ChaoDeFabricaUnidadeEntity({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.decimal,
  });

  ChaoDeFabricaUnidadeEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
    int? decimal,
  }) {
    return ChaoDeFabricaUnidadeEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      decimal: decimal ?? this.decimal,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaUnidadeEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && other.decimal == decimal;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ decimal.hashCode;
  }
}
