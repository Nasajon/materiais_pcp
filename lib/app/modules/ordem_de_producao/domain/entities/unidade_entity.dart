// ignore_for_file: public_member_api_docs, sort_constructors_first
class UnidadeEntity {
  final String id;
  final String codigo;
  final String nome;
  final int decimal;

  const UnidadeEntity({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.decimal,
  });

  factory UnidadeEntity.empty() {
    return const UnidadeEntity(id: '', codigo: '', nome: '', decimal: 2);
  }

  UnidadeEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
    int? decimal,
  }) {
    return UnidadeEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      decimal: decimal ?? this.decimal,
    );
  }

  @override
  bool operator ==(covariant UnidadeEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && other.decimal == decimal;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ decimal.hashCode;
  }
}
