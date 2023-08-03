// ignore_for_file: public_member_api_docs, sort_constructors_first
class TipoUnidadeEntity {
  final String id;
  final String fator;
  final String nome;
  final int decimal;

  const TipoUnidadeEntity({
    required this.id,
    required this.fator,
    required this.nome,
    required this.decimal,
  });

  @override
  bool operator ==(covariant TipoUnidadeEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.fator == fator && other.nome == nome && other.decimal == decimal;
  }

  @override
  int get hashCode {
    return id.hashCode ^ fator.hashCode ^ nome.hashCode ^ decimal.hashCode;
  }
}
