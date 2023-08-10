// ignore_for_file: public_member_api_docs, sort_constructors_first
class TipoUnidadeEntity {
  final String id;
  final String codigo;
  final String descricao;
  final int decimal;

  const TipoUnidadeEntity({
    required this.id,
    required this.codigo,
    required this.descricao,
    required this.decimal,
  });

  factory TipoUnidadeEntity.id(String id) {
    return TipoUnidadeEntity(
      id: id,
      codigo: '',
      descricao: '',
      decimal: 0,
    );
  }

  TipoUnidadeEntity copyWith({
    String? id,
    String? codigo,
    String? descricao,
    int? decimal,
  }) {
    return TipoUnidadeEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      decimal: decimal ?? this.decimal,
    );
  }

  @override
  bool operator ==(covariant TipoUnidadeEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.descricao == descricao && other.decimal == decimal;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ descricao.hashCode ^ decimal.hashCode;
  }
}
